function remove_ventricles(funcName)

%This requires you to have a nifti image of 1s and 0s. See
%nonzeros_to_ones.m

%templatePath = '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script';
templateName = '/Volumes/LJBIGBOY/prospectus_analysis/dissertation/ventricles.nii';
%'/Volumes/LJBIGBOY/projects/NeuralEntrainment/allscans/readytoprocess/wsrLesion_NE14M2212_NE.nii';

%filepath = '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script';
filepath =     '/Volumes/LJBIGBOY/prospectus_analysis/dissertation/aim_2/originalsLOOZ'
%output = '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script/pwaoutDir/noise_removed_output'

%conditions = dir(strcat([filepath, '/', 'LOO_R*.nii']));

%n = length(conditions);

%%% 
%Now that the path is set and filenames are pulled, let's get busy
% 
%  Leshdr = spm_vol(templateName);
%  Lesimg = spm_read_vols(Leshdr);
%if nargin<1, LesName = spm_select(Inf,'image','Select lesion '); end
if nargin<1, funcName = spm_select(Inf,'image','Select functional result'); end

%mni image has been loaded

%Now, we need a loop that will take all of the fmri images and multiply it
%by the MNI image... Fingers crossed

%Reslice func image to lesion image
nii_reslice_target(funcName,'',templateName,0);
[x y z] = spm_fileparts(funcName);

ventHdr = spm_vol(templateName);
ventImg = spm_read_vols(ventHdr);
ventImg = ~ventImg;
numNan = sum(ventImg(:) == 0);
fprintf('%s has %d voxels with zero value converted to not-a-number (NaN)\n', y, numNan);
ventImg = int8(ventImg);
 if numNan > 0
            ventHdr.fname = fullfile(filepath, ['NanIsVent' y z]);  
            
            ventImg(ventImg == 0) = NaN;
            %max(img(:)); % use ~isfinite instead of isnan to replace +/-inf with zero
            ventHdr.dt = [16,0];
            %img = - img;
            spm_write_vol(ventHdr,ventImg);
            
 end
 
funcName = strrep(funcName,y,['r' y]);

hdrF = spm_vol(funcName);
imgF = spm_read_vols(hdrF);

%Make lesion = 0, all else = 1
% Leshdr = spm_vol(templateName);
% Lesimg = spm_read_vols(Leshdr);
% %Vo = [y 'remove_outside.nii'];
% imgLes_inv = ~Lesimg; %getting the inverse of the original lesion to create inverse binary map
% out_name = ['inverse_template_' y 'test.nii']; %now we are saving the binary map
% out_dir =    '/Volumes/LJBIGBOY/prospectus_analysis/dissertation'; %location of where to save
% 
% roi_hdr = Leshdr; %making the correct hdr 
% roi_hdr.fname = [out_dir '/' out_name]; %''
% roi_hdr.pinfo = [1;0;0]; %''
% roi_hdr.private.dat.scl_slope = 1; %'' 
% roi_hdr.private.dat.scl_inter = 0; %''
% roi_hdr.private.dat.dtype = 'FLOAT32-LE'; %'' 
% roi_hdr.dt = [16,0]; %4= 16-bit integer; 16 =32-bit real datatype
% spm_write_vol (roi_hdr, imgLes_inv); %''

%and load it up
% hdrLesInv = spm_vol([out_dir '/' out_name]); %loading in our inversed lesion
% imgLesInv = spm_read_vols(hdrLesInv); %''

%%%


Vo = [y 'NAN_ventriclesFIN.nii'];
expr = [ 'i1.*i2' ];
spm_imcalc([ventHdr hdrF],Vo,expr)





