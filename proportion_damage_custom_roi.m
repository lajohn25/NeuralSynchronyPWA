
function proportion_damage_custom_roi(subjName, lesionName, lesionPath, roiName, roiPath)

%if nargin<2, atlasName = spm_select(1,'image','Select atlas'); end

if nargin<2, lesionName = spm_select(1,'image','Select lesion drawing'); end
if nargin<1, roiName = spm_select(Inf,'image','Select nii of ROI mask'); end
cd '/Users/lj4/Documents/projects/lesionsize_aq/master_matfiles_4.9.20';

%first we need to reslice the images to match each other
nii_reslice_target(lesionName, '', roiName,0);
[x y z] = spm_fileparts(lesionName);
lesionName = strrep(lesionName,y,['r' y]);

hdrLes = spm_vol(lesionName);
imgLes = spm_read_vols(hdrLes);
as_vector_lesion = reshape(imgLes,1,[]);
total_volume_lesion = sum(as_vector_lesion);

%as_vector_lesion(as_vector_lesion == 1) = 2;


hdrReg = spm_vol(roiName); 
imgReg = spm_read_vols(hdrReg);

Vo = [y 'lesionMultipliedByOnesInROI.nii'];
expr = [ 'i1.*i2' ];
spm_imcalc([hdrReg hdrLes],Vo,expr);

end_hdr = spm_vol([y 'lesionMultipliedByOnesInROI.nii']);
end_img = spm_read_vols(end_hdr);

as_vector = reshape(end_img,1,[]);
%new_vector = as_vector(as_vector ~= 0);
total_overlap_volume = sum(as_vector);

as_vector_ROI = reshape(imgReg,1,[]);
total_volume_ROI = sum(as_vector_ROI);

%prop = mean(new_vector);
prop =  total_overlap_volume/total_volume_ROI

fileID = fopen('proportion_damage_customROI_lh_pSTG.txt', 'a');
%fprintf(fileID,'%s\t %s\t %d \n', subjName, roiName, prop);
fprintf(fileID,'%s\t %s\t %d \n', lesionName, roiName, prop);
