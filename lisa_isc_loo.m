% This MATLAB script takes all the files in inDir that satisfy a certain
% searchstring then it calculates the average time course and all the
% leave-one-out correlations and saves them in outDir. The script uses the
% NIfTI toolbox, so make sure to install it in your path via:
% https://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image

% Make sure all the 4D files are in the same image space and have the same
% number of time-points or you'll get an error.

% Script written by Christian Keysers

% inDir= '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script'; %set this to where all your 4D files are
% outDir= '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script/outDir'; %create that directory before running the script
% 
% pwa_dir= '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script/pwa_dir'; %set this to where all your 4D files are
% pwa_outDir= '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script/pwaoutDir'; %create that directory before running the script

inDir =     '/Volumes/LJBIGBOY/prospectus_analysis/working_folder_indir'
outDir = '/Volumes/LJBIGBOY/prospectus_analysis/working_folder_outdir'


conditions = dir(strcat([inDir,'/','fdswa*.nii'])); %fdswa*.nii is the searchstring for your 4D files.
%pwa_conditions=dir(strcat([pwa_dir,'/','*dswa*.nii'])); %fdswa*.nii is the searchstring for your 4D files.

n=length(conditions);
%pwa_n=length(pwa_conditions);

%% Calculates the overall sum. 
% Because most PCs have limited memory, we do not load all the 4D files,
% but build up the mean by simply opening a file, adding it to a running sum,
% and then opening the next file into the same variable. Because we later use
% correlations, where the mean or the sum has the same effect, we use the sum.

% This will setup sum to contain the first image only
sum=load_nii(strcat(conditions(1).folder,'/',conditions(1).name)); 

for i=2:n
    tmp=load_nii(strcat(conditions(i).folder,'/',conditions(i).name));
    sum.img=sum.img+tmp.img;
end

%% Saves the sum for future use
save_nii(sum,strcat([pwa_outDir '/' 'sum.nii']));

sd=std(sum.img,[],4);

%% Gets the sizes of the 4D files to step through all the voxels
[x,y,z,t]=size(sum.img);
%% Calculate for each image, the correlation with others and the
% Fisher-z-transformed maps and saves into outDir.
% This script uses a simple trick: the average of other participants is not
% recalculated using all other participants, but simply as the sum minus this
% particular participant. This allows the process to only need the sum and
% one particular participant's 4D file to be open simultaneously.
% To make sure that the correlation images have the same header as the input
% images, I load the first volume of an image into rho, then zero the values in
% the .img.

rho_pwa=load_nii(strcat(pwa_conditions(1).folder,'/',pwa_conditions(1).name),1);
f_pwa = waitbar(0,'Please wait...');


for subj=1:pwa_n
    waitbar(subj/pwa_n,f_pwa,strcat(['starting to process subject ',num2str(subj,'%02.fpwa')]));
    tmp_pwa=load_nii(strcat(pwa_conditions(subj).folder,'/',pwa_conditions(subj).name));
    %tmp_pwa.img = single(tmp_pwa.img);
    rho_pwa.img=NaN(x,y,z);

    for xi=1:x
        for yi=1:y
            for zi=1:z
                if not(sd(xi,yi,zi)==0)  % excludes voxels with zero variance
                  rho_pwa.img(xi,yi,zi)=corr(squeeze(tmp_pwa.img(xi,yi,zi,:)),squeeze(sum.img(xi,yi,zi,:)));
                end
            end
        end
    end
    


    save_nii(rho_pwa,strcat([pwa_outDir '/' 'LOO_R_' num2str(subj,'%02.f_pwa') '.nii']));
    fisherz_pwa=rho_pwa;
    fisherz_pwa.img=atanh(rho_pwa.img);
    save_nii(fisherz_pwa,strcat([pwa_outDir '/' 'LOO_Z_' num2str(subj,'%02.f_pwa') '.nii']));
end


