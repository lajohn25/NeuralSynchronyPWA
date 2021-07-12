%INPUTSDLG DEMO (Enhanced input dialog box with multiple data types)

% Written by: Takeshi Ikuma

% Last Updated: May 5 2010

% Updated for additional functions F. Hatz 2013

%Modified by RNN 01-20-2018

 

clear; 

close all;

 

Title = 'ATLAS BASED ROI SIGNAL EXTRACTOR v1.0';

 

%%%% SETTING DIALOG OPTIONS

% Options.WindowStyle = 'modal';


Options.Resize = 'on';

Options.Interpreter = 'tex';

Options.CancelButton = 'on';

Options.ApplyButton = 'on';

Options.ButtonNames = {'Continue','Cancel'}; %<- default names, included here just for illustration

Options.Dim = 4; % Horizontal dimension in fields

 

Prompt = {};

Formats = {};

DefAns = struct([]);

 

d = dir('M1*');

files = strcat([pwd filesep],{d(~[d.isdir]).name});

 

Prompt(1,:) = {'This is for Sam',[],[]};

Formats(1,1).type = 'text';

Formats(1,1).size = [-1 0];

Formats(1,1).span = [1 2]; % item is 1 field x 4 fields

 

Prompt(2,:) = {'OUTPUT File Name''s Name', 'Name',[]};

Formats(2,1).type = 'edit';

Formats(2,1).format = 'text';

Formats(2,1).size = 200; % automatically assign the height

DefAns(1).Name = 'results';

 

Prompt(3,:) = {'Save output to this folder','DataFolder',[]};

Formats(3,1).type = 'edit';

Formats(3,1).format = 'dir';

Formats(3,1).size = [-1 0];

Formats(3,1).span = [1 3];  % item is 1 field x 3 fields

DefAns.DataFolder = pwd;

 

Prompt(4,:) = {'Select Files To Extract ROIs From','fnames',[]};

Formats(4,1).type = 'edit';

Formats(4,1).format = 'file';

Formats(4,1).limits = [0 5]; % multi-select files

Formats(4,1).size = [-1 -1];

Formats(4,1).items = {'*.nii','Auction Item File';'*.*','All Files'};

Formats(4,1).span = [1 3];  % item is 1 field x 3 fields

DefAns.fnames = files(3:end);

 

Prompt(5,:) = {'Choose Atlas','MoneyUnit',[]};

Formats(5,1).type = 'list';

Formats(5,1).format = 'text';

Formats(5,1).style = 'radiobutton';

Formats(5,1).items = {'jhu' 'AICHA' 'bro';'bro' 'aal' 'aalcat'; 'customAtlas_controls_NE_PeakClusters' 'Fox' 'Fox'};

Formats(5,1).span = [3 3];  % item is 2 field x 1 fields

DefAns.MoneyUnit = 'jhu';%3; % yen

 

Prompt(6,:) = {'Choose ROI(s) To Extract Signal From','ROIs',[]};

Formats(6,1).type = 'edit';

Formats(6,1).format = 'vector';

Formats(6,1).limits = [0 100]; % 100 parameters max

 

Prompt(end+1,:) = {'','XY',[]};

Formats(11,4).type = 'edit';

Formats(11,4).format = 'text';

Formats(11,4).enable = 'inactive';

Formats(11,4).size = [100 25];



DefAns.XY = 'Click Continue to Continue...';

 

%Get Answer

[Answer,Cancelled] = inputsdlg(Prompt,Title,Formats,DefAns,Options)

%Answer = inputdlg(Prompt,Title,Formats,DefAns,Options);

%Use Answer to run task

roi_list = str2num(Answer.ROIs);

 Answer.fnames = { 
    '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE02/fdswaRest_NE02_NE.nii'
    '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE05M2181P1030/fdswaRest_NE05M2181P1030_NE.nii'
    '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE06M2185P1036/fdswaRest_NE06M2185P1036_NE.nii'
    '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE07M2031/fdswaRest_NE07M2031_NE.nii'
    '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE08M2176/fdswaRest_NE08M2176_NE.nii'
    '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE10M2172/dswaRest_NE10M2172_NE.nii'
    '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE12M2200/dswaRest_NE12M2200_NE.nii'
    '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE14M2212/fdswaRest_NE14M2212_NE.nii'
    '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE15M2216/dswaRest_NE15M2216_NE.nii'
    '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE17M2221/dswaRest_NE17M2221_NE.nii'
    '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE18M2177/dswaRest_NE18M2177_NE.nii'
    '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE19M2005/dswaRest_NE19M2005_NE.nii'
    '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE20M2220/dswaRest_NE20M2220_NE.nii'
    '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE21DRM2168/fdswaRest_NE21DRM2168_NE.nii'
    '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE22M2223/dswaRest_NE22M2223_NE.nii'
'/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/output/NE34M2238/fdswaRest_NE34M2238_NE.nii'
     '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script/pwa_dir/average_control_timeseries.nii'
     
};

for p = 1:length(Answer.fnames)

    

    fmri_fname = Answer.fnames{p};

                

    fmri_hdr = spm_vol (fmri_fname);

    

    fmri_dat = spm_read_vols (fmri_hdr);

  

    % end_vols (fmri_hdr);

    

    niistat_folder = fileparts (which('NiiStat'));

    atlas_hdr = spm_vol ([niistat_folder '/roi/' Answer.MoneyUnit '.nii']);

    atlas_dat = spm_read_vols (atlas_hdr);

 

    [atlas_rhdr, atlas_rdat] = nii_reslice_target (atlas_hdr, atlas_dat, fmri_hdr(1), false);

    roi_idx = [];

    for i = 1:length (roi_list)

        roi_idx = find(atlas_rdat == roi_list(i));

    %end

 

       mean_timecourse = [];

       for j = 1:length(fmri_hdr)

           volume = fmri_dat (:, :, :, j);

           roi = volume (roi_idx);

           mean_timecourse_data(i,j) = [mean_timecourse mean(roi(:), 'omitnan')];

       end

    
    end
    
    [x y z] = spm_fileparts(fmri_fname)

    FileName = sprintf('%s%s%s',y,'_ExtractTS_rest_35on','.txt');
    %save(FileName,'mean_timecourse_data');
    dlmwrite(fullfile(Answer.DataFolder,FileName), mean_timecourse_data,'delimiter', '\t', 'precision',8);

    
end

 

%dlmwrite(fullfile(Answer.DataFolder,strcat(Answer.Name,'.txt')), mean_timecourse_data,'delimiter', '\t', 'precision',8);

%open(fullfile(Answer.DataFolder,strcat(Answer.Name,'.txt')));


