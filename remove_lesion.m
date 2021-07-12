function remove_outside_mni_activity(funcName)

%This requires you to have a nifti image of 1s and 0s. See
%nonzeros_to_ones.m

%templatePath = '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script';
%templateName = '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script/MNI_binary.nii';
%'/Volumes/LJBIGBOY/projects/NeuralEntrainment/allscans/readytoprocess/wsrLesion_NE14M2212_NE.nii';

%filepath = '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script';
cd     '/Volumes/LJBIGBOY/prospectus_analysis/dissertation/aim_2/originalsLOOZ';
filepath =     '/Volumes/LJBIGBOY/prospectus_analysis/dissertation/aim_2';
%output = '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script/pwaoutDir/noise_removed_output'

%conditions = dir(strcat([filepath, '/', 'LOO_R*.nii']));

%n = length(conditions);

%%% 
%Now that the path is set and filenames are pulled, let's get busy
% 
% Leshdr = spm_vol(templateName);
% Lesimg = spm_read_vols(Leshdr);
if nargin<1, LesName = spm_select(Inf,'image','Select lesion '); end
if nargin<1, funcName = spm_select(Inf,'image','Select functional result'); end

%mni image has been loaded

%Now, we need a loop that will take all of the fmri images and multiply it
%by the MNI image... Fingers crossed

%Reslice func image to lesion image
nii_reslice_target(funcName,'',LesName,0);
[x y z] = spm_fileparts(funcName);
funcName = strrep(funcName,y,['r' y]);

hdrF = spm_vol(funcName);
imgF = spm_read_vols(hdrF);

%Make lesion = 0, all else = 1
Leshdr = spm_vol(LesName);
Lesimg = spm_read_vols(Leshdr);
%Vo = [y 'remove_outside.nii'];
imgLes_inv = ~Lesimg; %getting the inverse of the original lesion to create inverse binary map

numNan = sum(imgLes_inv(:) == 0);
fprintf('%s has %d voxels with zero value converted to not-a-number (NaN)\n', y, numNan);
imgLes_inv = int8(imgLes_inv);
 if numNan > 0
            Leshdr.fname = fullfile(filepath, ['NanIsLes' y z]);  
            
            imgLes_inv(imgLes_inv == 0) = NaN;
            %max(img(:)); % use ~isfinite instead of isnan to replace +/-inf with zero
            Leshdr.dt = [16,0];
            %img = - img;
            spm_write_vol(Leshdr,imgLes_inv);
            
 end

%Leshdr.fname = fullfile(pth, ['NaNLes_' y z]);  
            
           %img(img == 0) = NaN;%max(img(:)); % use ~isfinite instead of isnan to replace +/-inf with zero
%Leshdr.dt = [16,0];
%out_name = ['NaN_lesion_' y 'test.nii']; %now we are saving the binary map
out_dir =        '/Volumes/LJBIGBOY/prospectus_analysis/dissertation/aim_2/originalsLOOZ'; %location of where to save


% roi_hdr = Leshdr; %making the correct hdr 
% roi_hdr.fname = [out_dir '/' out_name]; %''
% roi_hdr.pinfo = [1;0;0]; %''
% roi_hdr.private.dat.scl_slope = 1; %'' 
% roi_hdr.private.dat.scl_inter = 0; %''
% roi_hdr.private.dat.dtype = 'FLOAT32-LE'; %'' 
% roi_hdr.dt = [16,0]; %4= 16-bit integer; 16 =32-bit real datatype
% spm_write_vol (roi_hdr, imgLes_nan); %''



%and load it up
%hdrLesInv = spm_vol([out_dir '/' out_name]); %loading in our inversed lesion
%imgLesInv = spm_read_vols(hdrLesInv); %''

% fnm = [out_dir '/' out_name]
% nii_nanzero_lj(fnm);

%hdrLesNan = spm_vol([out_dir '/z' out_name]); %loading in our inversed lesion
%%%


Vo = [y 'NAN_lesionNEW.nii'];
expr = [ 'i1.*i2' ];
spm_imcalc([Leshdr hdrF],Vo,expr)


newHdr = spm_vol([out_dir '/' Vo]); %loading in our inversed lesion
[x y z] = spm_fileparts(newHdr.fname);
newImg = spm_read_vols(newHdr); %''

remove_outside_mni_activity(newHdr.fname);

nextHdr = spm_vol([x '/r' y 'NAN_outside.nii']);

remove_ventricles(nextHdr.fname)