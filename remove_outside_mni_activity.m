function remove_outside_mni_activity(funcName)

%This requires you to have a nifti image of 1s and 0s. See
%nonzeros_to_ones.m

%templatePath = '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script';
%templateName = '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script/MNI_binary.nii';
%templateName =     '/Volumes/LJBIGBOY/prospectus_analysis/dissertation/aim_2/rspm_binary.nii';


%filepath = '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script';

%swap below filepaths for control vs pwa
%filepath =         '/Volumes/LJBIGBOY/prospectus_analysis/dissertation/aim_2/originalsLOOZ';
filepath = '/Volumes/LJBIGBOY/prospectus_analysis/dissertation/conrols_LOO';

%conditions = dir(strcat([filepath, '/', '*NAN_lesionNew.nii']));
conditions = dir(strcat([filepath, '/', 'LOO_Z*.nii']));

%n = length(conditions);

%%% 
%Now that the path is set and filenames are pulled, let's get busy

% MNIhdr = spm_vol(templateName);
% MNIimg = spm_read_vols(MNIhdr);

templateName =     '/Volumes/LJBIGBOY/prospectus_analysis/dissertation/aim_2/originalsLOOZ/rspm_binary.nii';

%if nargin<1, templateName = spm_select(Inf, 'image', 'Select lesion tracing'); end
MNIhdr = spm_vol(templateName);
MNIimg = spm_read_vols(MNIhdr);
if nargin<1, funcName = spm_select(Inf,'image','Select functional results'); end

%mni image has been loaded

%Now, we need a loop that will take all of the fmri images and multiply it
%by the MNI image... Fingers crossed
nii_reslice_target(funcName,'',templateName,0);
[x y z] = spm_fileparts(funcName);
funcName = strrep(funcName,y,['r' y]);

% nii_reslice_target(funcName,'',templateName,0);
 [x y z] = spm_fileparts(funcName);
% funcName = strrep(funcName,y,['r' y]);

numNan = sum(MNIimg(:) == 0);
fprintf('%s has %d voxels with zero value converted to not-a-number (NaN)\n', y, numNan);
MNIimg = int8(MNIimg);
 if numNan > 0
            MNIhdr.fname = fullfile(filepath, ['NanIsTemp' y z]);  
            
            MNIimg(MNIimg == 0) = NaN;
            %max(img(:)); % use ~isfinite instead of isnan to replace +/-inf with zero
            MNIhdr.dt = [16,0];
            %img = - img;
            spm_write_vol(MNIhdr,MNIimg);
            
 end
 
 
hdrF = spm_vol(funcName);
imgF = spm_read_vols(hdrF);
Vo = [y 'NAN_outside.nii'];
%Vo = [y 'remove_in_lesion.nii'];
expr = [ 'i1.*i2' ];
spm_imcalc([MNIhdr hdrF],Vo,expr)

%For controls only
newHdr = spm_vol([x '/' Vo])


remove_ventricles(newHdr.fname)