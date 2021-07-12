function fmri2roi(fmri, roi)
%Extract voxels from 4D fmri in region of interest
% fmri: 4D fmri scan with dimensions XYZT
% roi: region of interest map with N discrete regions
%Result:
% image with dimensions N11T 
%Examples
% fmri2roi %use GUI
% fmri2roi('fdswaRest_NE09_NE.nii', 'AICHA.nii')
if ~exist('fmri','var')
	fmri = spm_select(1,'image','Select 4D fMRI dataset'); 
end
[p,n,x] = spm_fileparts(fmri);
fmri  = fullfile(p,[n,x]); %remove volume number '~/fMRI.nii,1' -> '~/fMRI.nii'
if ~exist('roi','var')
	roi = spm_select(1,'image','Select 3D template with regions of interest'); 
end

rhdr = spm_vol(roi);
rimg = spm_read_vols(rhdr);
hdr = spm_vol(fmri);
img = spm_read_vols(hdr);
nxyz = size(img,1) * size(img,2) * size(img,3); %spatial dimensions
nt = size(img, 4); %number of timepoints
if nt < 2 
   error('Expected 4D time series %s', fmri); 
end
hdr = hdr(1);
if (size(img, 1) ~= size(rimg, 1)) ||  (size(img, 2) ~= size(rimg, 2)) || (size(img, 3) ~= size(rimg, 3)) 
    fprintf('XXX\n');
    [rhdr, rimg] = nii_reslice_target(rhdr, rimg, hdr, 0);
end
nroi = max(rimg(:));
fprintf('%d regions in %s\n', nroi, roi);
fprintf('%d timepoints in %s\n', nt, fmri);
img = reshape(img, nxyz, nt);
img(isnan(img)) = 0;
oimg = zeros(nroi,nt);
rimg = reshape(rimg, nxyz, 1); 
for r = 1 : nroi
    v = img(rimg(:)== r, :);
    fprintf('region %d has %d voxels\n', r, size(v,1));
    mn = mean(v);
    oimg(r,:) = mn;
end
%save reduced data
hdr.pinfo = [1;0;0]; %remove scale/intercept
hdr.dt =[64,0]; %double precision
[~, rnm] = spm_fileparts(roi);
[pth, nm, ext] = spm_fileparts(fmri);
hdr.fname = fullfile(pth, [rnm '_' nm ext]);
hdr.dim = [nroi,1,1];
for t = 1 : nt
    hdr.n(1) = t;
    spm_write_vol(hdr,oimg(:, t));
end

        





