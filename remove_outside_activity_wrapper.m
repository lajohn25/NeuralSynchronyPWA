%this is for a mass number of functional scans so you can do them in bulk
clear all
%fmri_pathname = '/Users/lj4/Documents/projects/tACS/drawing_frois/fmri_only';
funcPath =         '/Volumes/LJBIGBOY/prospectus_analysis/dissertation/aim_2/originalsLOOZ';



cd (funcPath);
d = dir ('*NAN_lesionNew.nii');
for i = 1:length (d)
   %if d(i).isdir
       %subj_name{i} = d(i).name;
       %lesion_name = [subj_name{i} '_lesion.nii'];
      subjhdr{i} = spm_vol(d(i));
       
       
       %subj_name{i} = [d(i).folder, '/', d(i).name];
       
       remove_outside_mni_activity(subjhdr);
end

        