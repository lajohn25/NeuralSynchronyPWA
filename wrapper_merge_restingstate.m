%this wrapper will help us merge out two FG scans into one large scan,
%which we can then feed into our nii_harvest and become preprocessed along
%with our other scans.

cd '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/Archive_aphasia_NEEDSCANS'
%cd     '/Users/lj4/Documents/projects/NeuralEntrainment/all_scans_from_server/APHASIA_WORKING_PREPROCESS'


d = dir ('NE*');
for i = 1:length (d)
    if isdir (d(i).name)
        subj_name{i} = d(i).name;
        subj_path = [pwd '/' subj_name{i}];
        file_path = [pwd '/' subj_name{i} '/' 'NE']
        cd (file_path)
        
        d1 = dir ('FreaksGeeks1*.nii');
        d2 = dir ('FreaksGeeks2*.nii');
        if length (d1) > 0
            file1name = d1(1).name;
            file2name = d2(1).name;
        
        file1 = fullfile(file_path, file1name);
        file2 = fullfile(file_path, file2name);

        
        
        merge_restingstate(subj_path, file1, file2)
        end 

        
        cd ('..');
    end
end
