inDir= '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script/pwaoutDir'; %set this to where all your 4D files are
outDir= '/Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script/pwaoutDir'; %create that directory before running the script
conditions=dir(strcat([inDir,'/','LOO_R*outside.nii'])); %fdswa*.nii is the searchstring for your 4D files.

n=length(conditions);


avg=load_nii(strcat(conditions(1).folder,'/',conditions(1).name)); 

for i=2:n
    tmp=load_nii(strcat(conditions(i).folder,'/',conditions(i).name));
    avg.img = avg.img + tmp.img;
end

avg.img = (avg.img/n);

save_nii(avg,strcat([outDir '/' 'average_pwa.nii']));
