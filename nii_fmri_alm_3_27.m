function nii_fmri_alm_3_27(fmriname, t1name, t2name, lesion_name)
%analyze data in a naming task
% t1name   : filename for T1 scan
% fmriname : filename for fMRI scan

if ~exist('fmriname','var')
	fmriname = spm_select(1,'image','Select fMRI scan'); 
end

if ~exist('t1name','var') || isempty(t1name)
	p.t1name = -1;% t1name; 
else
    p.t1name = t1name;
end

if exist('t2name','var') && ~isempty(t2name)
	p.t2name = t2name; 
    %GY, Oct 5, 2017
    if exist('lesion_name','var') && ~isempty(lesion_name)
        p.lesion_name = lesion_name; 
    end
end

p.fmriname = fmriname;
% p.t1name = t1name;
% p.t2name = t2name;
% p.lesion = lesion_name;
p.setOrigin = true;
p.TRsec = 1; %repeat time is 1.92 seconds per volume
p.slice_order = -1; %SKIP
p.phase =  ''; %phase image from fieldmap
p.magn = ''; %magnitude image from fieldmap
%statistical information (optional: if not provided not statitics)
p.names{1} = 'words';
p.names{2} = 'symbols';
%p.names{2} = 'abstract';
%onsets for 1st session, onsets{session, cond}
p.duration{1} = 20; %duration 1 for events, longer for blocks
p.duration{2} = 20;
%condition 1: named pictures
%p.onsets{1,1} = [5	10	15	20	43.333	46.667	50	53.333	56.667	60	82.857	85.714	88.571	91.429	94.286	97.143	100	122.857	125.714	128.571	131.429	134.286	137.143	140	162.5	165	167.5	170	172.5	175	177.5	180	202.222	204.444	206.667	208.889	211.111	213.333	215.556	217.778	220	242.5	245	247.5	250	252.5	255	257.5	260	282	284	286	288	290	292	294	296	298	300	324	328	332	336	340	362.857	365.714	368.571	371.429	374.286	377.143	380];
p.onsets{1,1} = [0 40 80 120 160 200 240 280 320 360]
p.onsets{1,2} = [20 60 100 140 180 220 260 300 340 380]
%condition 2: silent abstract images
%p.onsets{1,2} = [7.541 53.809 76.792 92.255 115.021 143.892 154.017 176.667 224.02 233.376 283.163 297.824 316.889 422.767 452.773 487.716 492.688 526.645 552.364 565.857 612.075 637.978 657.893 665.265 685.58 707.18 763.989 776.565 866.182 873.053 897.572 913.1 937.902 1004.836 1037.376 1074.07 1144.122 1174.011 1183.47 1196.762];
%p.onsets{1,1} = p.onsets{1,1} - (p.TRsec/2); %we will time from start not middle of acq
%p.onsets{1,2} = p.onsets{1,2} - (p.TRsec/2); %we will time from start not middle of acq
%CR 10/2017 SPARSE DESIGN subtract one second, TA=2.0, no slice timing correction, T0=1
%p.onsets{1,1} = p.onsets{1,1} - 1.0;
%p.onsets{1,2} = p.onsets{1,2} - 1.0;
p.statAddSimpleEffects = true;
%cropVolumesSub(fmriname, 0, 60); %Crop to precisely 60 volumes
p.mocoRegress = false; %should motion parameters be included in statistics?
nii_batch12(p);
%end nii_fmri60()

function cropVolumesSub(fnm, skipVol, nVol)
%ensure that image 'fnm' has no more than nVol volumes
[p,n,x] = spm_fileparts(fnm);
matName = fullfile(p,[n,'.mat']);
if exist(matName,'file'), fprintf('Deleting mat file (motion correction will replace this) : %\n', matName); delete(matName); end;
rpName = fullfile(p,['rp_', n,'.txt']);
if exist(rpName,'file'), fprintf('Deleting text file (motion correction will replace this) : %\n', rpName); delete(rpName); end;
hdr = spm_vol(fnm); 
img = spm_read_vols(hdr);
[nX nY nZ nV] = size(img);
if (skipVol < 0), skipVol = 0; end;
if ( (skipVol+nVol) > nV), nVol = nV - skipVol; end;
if ((skipVol == 0) && (nVol == nV)), return; end;
if ~strcmpi(x,'.nii') %unzip compressed data
    error('Only able to process ".nii" images %s', mfilename);
end;
fnmOrig = fullfile(p, [n, '_v', int2str(nV), x]);
movefile(fnm, fnmOrig);
fprintf('%s has volumes %d..%d volumes from %s\n',fnm,skipVol+1,skipVol+nVol,fnmOrig); 
hdr = hdr(1);
hdr.fname   = fnm;
for vol=1:nVol
    hdr.n(1)=vol;
    imgMod = img(:, :, :, skipVol+vol);
    spm_write_vol(hdr,imgMod(:, :, :, 1));
end;
%end cropVolumesSub();