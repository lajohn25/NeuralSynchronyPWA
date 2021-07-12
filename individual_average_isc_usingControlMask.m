%cd     '/Volumes/LJBIGBOY/prospectus_analysis/dissertation/conrols_LOO';
cd     '/Volumes/LJBIGBOY/prospectus_analysis/dissertation/aim_2/originalsLOOZ';
maskName =  '/Volumes/LJBIGBOY/prospectus_analysis/dissertation/conrols_LOO/average_control_maskPoint3.nii';
warning ('off', 'all');

d = dir ('FIN*FIN.nii');
for i = 1:length (d)
    pname = d(i).name;
    hdr = spm_vol(pname);
    img = spm_read_vols(hdr);
    
    maskHDR = spm_vol(maskName);
    maskIMG = spm_read_vols(maskHDR);
    
    %Reslice func image to lesion image
    nii_reslice_target(pname,'',maskName,0);
    [x y z] = spm_fileparts(pname);
    pname = strrep(pname,y,['r' y]);
    
    Vo = [y 'ISCinMask.nii'];
    expr = [ 'i1.*i2' ];
    spm_imcalc([maskHDR hdr],Vo,expr);
    
    newHdr = spm_vol(Vo); %loading in our inversed lesion
    newImg = spm_read_vols(newHdr); %''

    nii_nanzero_lj(newHdr.fname);
    
    FINHdr = spm_vol(['FINz' Vo]);
    FINImg = spm_read_vols(FINHdr);
    
    avg_isc = mean(FINImg(:), 'omitnan');
    sd_isc = std(FINImg(:), 'omitnan');
    
    %if exist(l.lesion)
     % d1 = l.lesion;
     %if length (d1) > 1
        %lesion_size = sum (l.lesion.dat(:));
        disp (['Participant ' pname ': average wholebrain ISC ' num2str(avg_isc) ' with a SD of ' num2str(sd_isc)]);
    %else 
        
    % end
    % end
end

