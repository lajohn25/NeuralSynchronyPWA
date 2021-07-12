function merge_restingstate (pathName, file1, file2)

%Roger wrote this script for combining the two freaks and geeks scans into
%one long resting state file. we are going to merge them together so we can
%write a "resting state" scan into our matfiles, that way we can run
%analyses in niistat. -lj

%select directory to write results
selpath = pathName;
%cd '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/aphasia'
%cd(selpath)

%select files to split apart, and then merge
% file1 = spm_select;
 copyfile(file1,fullfile(selpath,'file1.nii'));
% %delete(file1)
 file1 = fullfile(selpath,'file1.nii')
% file2 = spm_select;
 copyfile(file1,fullfile(selpath,'file2.nii'));
% %delete(file2)
 file2 = fullfile(selpath,'file2.nii')

% if ~exist('file1','var') %no input: select imgs[s]
%     file1 = spm_select(inf,'image','Select FG1 volumes[s]');
%     if isempty(file1), 
%         return; 
%     end
% end;
% if ~exist('t1name','var') %no input: select imgs[s]
%     t1name = spm_select(1,'image','(Optional) Select T1 anatomical scan');
% end
%     %imgs.SE = spm_select(1,'image','(Optional) select spin-echo scan for undistortion');
%     %imgs.SE = spm_select(1,'image','(Optional) select reversed-phase spin-echo scan for undistortion');
% if ~exist('t2name','var') %no input: select imgs[s]
%     t2name = spm_select(1,'image','(Optional) Select T2 pathological scan');
% end

% hdrFile1 = spm_vol(file1Name);
% file1 = spm_read_vols(hdrFile1);
% 
% hdrFile2 = spm_vol(file2Name);
% file2 = spm_read_vols(hdrFile2);

%split files up in the directory you chose above (line 2)
spm_file_split(file1);
spm_file_split(file2);



delete(file1)
delete(file2)

%now merge all the little niftis in selpath directory into a giant one
spm_file_merge();

%rename it for future
cd (selpath);
movefile('4D.nii','Rest_FG_combined.nii')