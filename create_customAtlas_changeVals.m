clear all

%function create_customAtlas_changeVals(roiName, roiPath)


roiPath = '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/seperate_files_processed/ALM_ROI_ANALYSIS_6.1.2020';
cd (roiPath)


roiName = spm_select(Inf,'image','Select nii of ROI mask'); 
%because I drew the ROIs in normalized space, I do not need to reshape.
%But, should you need to reshape in the future, the lines to do so are
%below.

%first we need to reslice the images to match each other
%nii_reslice_target(lesionName, '', roiName,0);
%[x y z] = spm_fileparts(lesionName);
%roiName = strrep(roiName,y,['r' y]);
[x y z] = spm_fileparts(roiName);

atlas_hdr = spm_vol(roiName);
atlas_dat = spm_read_vols(atlas_hdr);
%as_vector_roi = reshape(imgReg,1,[]);
atlas_dat(atlas_dat > 0) = 7;
atlas_dat = int32(floor(atlas_dat));

%first make a copy of the loaded hdr and dat
newfile_hdr = atlas_hdr; 
newfile_dat = int32(floor(atlas_dat));

 %now change the filename in the newfile_hdr so when you use spm_write_vol 
 %you save it as a different filename, else you will overwrite the original!
 newfile_hdr.fname = fullfile(pwd, 'lh_ba39.nii');
 
 %finally, create the new .nii image, based on that hdr structure and the dat structure
spm_write_vol(newfile_hdr, newfile_dat) 