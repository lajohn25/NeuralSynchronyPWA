%Select all of the rois you want in an atlas
clear all

roiPath = '/Users/lj4/Documents/dissertation';
cd (roiPath)


roi1 = spm_select(Inf,'image','Select nii of ROI masks'); 
roi2 = spm_select(Inf,'image','Select nii of ROI masks'); 
roi3 = spm_select(Inf,'image','Select nii of ROI masks'); 
roi4 = spm_select(Inf,'image','Select nii of ROI masks'); 
roi5 = spm_select(Inf,'image','Select nii of ROI masks'); 
roi6 = spm_select(Inf,'image','Select nii of ROI masks'); 
roi7 = spm_select(Inf,'image','Select nii of ROI masks'); 
roi8 = spm_select(Inf,'image','Select nii of ROI masks'); 
roi9 = spm_select(Inf,'image','Select nii of ROI masks'); 
roi10 = spm_select(Inf,'image','Select nii of ROI masks'); 

aatlas_hdr = spm_vol(roi1);
aatlas_dat = spm_read_vols(aatlas_hdr);

batlas_hdr = spm_vol(roi2);
batlas_dat = spm_read_vols(batlas_hdr);

catlas_hdr = spm_vol(roi3);
catlas_dat = spm_read_vols(catlas_hdr);

datlas_hdr = spm_vol(roi4);
datlas_dat = spm_read_vols(datlas_hdr);

eatlas_hdr = spm_vol(roi5);
eatlas_dat = spm_read_vols(eatlas_hdr);

fatlas_hdr = spm_vol(roi6);
fatlas_dat = spm_read_vols(fatlas_hdr);

gatlas_hdr = spm_vol(roi7);
gatlas_dat = spm_read_vols(gatlas_hdr);

hatlas_hdr = spm_vol(roi8);
hatlas_dat = spm_read_vols(hatlas_hdr);

iatlas_hdr = spm_vol(roi9);
iatlas_dat = spm_read_vols(iatlas_hdr);

jatlas_hdr = spm_vol(roi10);
jatlas_dat = spm_read_vols(jatlas_hdr);



Vo = ['customAtlas_controls_NE_PeakClusters.nii'];
expr = ['i1 + i2 + i3 + i4 + i5 + i6 + i7 + i8 + i9 + i10'];
spm_imcalc([aatlas_hdr batlas_hdr catlas_hdr datlas_hdr eatlas_hdr fatlas_hdr gatlas_hdr hatlas_hdr iatlas_hdr jatlas_hdr],Vo,expr);
%to get rid of decimals in roi values, I had to edit spm_imcalc lilne 149
%to be [1 0 0] (see
%https://www.jiscmail.ac.uk/cgi-bin/webadmin?A2=SPM;d3789823.2003)