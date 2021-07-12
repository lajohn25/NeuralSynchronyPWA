clear all

cd /Users/lj4/Documents/projects/NeuralEntrainment/allscans/readytoprocess/using_isc_loo_script;


d = dir ('fdswaRest*');
for i = 1:length (d)
   
            fmriname = d(i).name;
                     
            roiname = 'AICHA.nii';
            
    
       fmri2roi(fmriname, roiname);
end


            
