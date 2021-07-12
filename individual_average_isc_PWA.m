%cd     '/Volumes/LJBIGBOY/prospectus_analysis/dissertation/conrols_LOO';
cd   '/Volumes/LJBIGBOY/prospectus_analysis/dissertation/aim_2/originalsLOOZ';
warning ('off', 'MATLAB:unknownElementsNowStruc');

d = dir ('FINz*FIN.nii');
for i = 1:length (d)
    pname = d(i).name;
    hdr = spm_vol(pname);
    img = spm_read_vols(hdr);
    avg_isc = mean(img(:), 'omitnan');
    sd_isc = std(img(:), 'omitnan');
     %if exist(l.lesion)
     % d1 = l.lesion;
     %if length (d1) > 1
        %lesion_size = sum (l.lesion.dat(:));
        disp (['Participant ' pname ': average wholebrain ISC ' num2str(avg_isc) ' with a SD of ' num2str(sd_isc)]);
    %else 
        
    % end
    % end
end

