function vector2ROI(fnm, roi)
%Convert voxelwise image ISC image to ROI
% fnm: NIfTI LOO R image 
% roi: region of interest map with dimensions XYZ and N discrete regions
%Result:
% image with dimensions XYZ 
%Examples
% vector2atlas %use GUI
% vector2atlas('LOO_R_01_NE01remove_outside.nii', 'AICHA.nii')

if ~exist('fnm','var')
	fnm = spm_select(1,'image','Select vector dataset'); 
end
if ~exist('roi','var')
	roi = spm_select(1,'image','Select 3D template with regions of interest'); 
end

%Make sure our images are in the same space
rhdr = spm_vol(roi);
rimg = spm_read_vols(rhdr);
hdr = spm_vol(fnm);
img = spm_read_vols(hdr);

nroi = max(rimg(:));

[p,n,x] = spm_fileparts(fnm);

%make sure our images match each other (check with fslhd):
[~, img] = nii_reslice_target(hdr, img, rhdr, true);
%nxyz = size(img,1) * size(img,2) * size(img,3); %spatial dimensions
%nt = size(img, 4); %number of timepoints

n_rois = unique(rimg(rimg ~= 0)); %get a list of all ROIs (ignoring empty space (0's))
oimg = zeros(nroi,1);

%Calculate average BOLD in ROI
for i = 1 : length(n_rois) %For each ROI
    roinum = n_rois(i);
    mn = mean(img(rimg == roinum));
    fprintf('\t%d\t%g\n', roinum, mn); %The data printed in the txt file
    oimg(i,:) = mn; %values we want to map

end

% %save reduced data
hdr.pinfo = [1;0;0]; %remove scale/intercept
hdr.dt =[64,0]; %double precision
[~, rnm] = spm_fileparts(roi);
[pth, nm, ext] = spm_fileparts(fnm);
hdr.fname = fullfile(pth, [rnm '_' nm '_ljTest' ext]);
hdr.dim = [nroi,1,1];
spm_write_vol(hdr,oimg(:));

fnm = hdr.fname

vector2atlas(fnm, roi);