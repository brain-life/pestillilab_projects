% This script makes the white-matter mask used to track the connectomes in
% Caiafa and Pestilli Manuscript.
%
% Input is the parcellated and segmented white matter mask from freesurfer segmentation 
% (github.com/brain-life/pestillilab_projects/Concussion/freesurfer_segmentation), subject (subj), and anatomy 
% directory (anatomypath).
%
% Output will be wmMask.nii.gz file.  This will be used in mrtrix tracking 
% (github.com/brain-life/pestillilab_projects/zero6_ensemble_tractography).
%
% 2017 Brad Caron Indiana University, Pestilli Lab 

% Get the base directory for the data; edit for your data and file structure
anatomypath = '/N/dc2/projects/lifebid/Concussion/concussion_test';
subjects = '1_005';

wmMaskFile = fullfile(anatomypath,subjects{isbj},'diffusion_data', '1000', 'Anatomy', 'wmMask.nii.gz');    
fs_wm = fullfile(anatomypath,subjects{isbj},'diffusion_directory', 'Anatomy', 'aparc+aseg.nii.gz');
fprintf('\n loading %s \n',fs_wm);
wm = niftiRead(fs_wm);
wm.fname = wmMaskFile;
invals  = [2 41 16 17 28 60 51 53 12 52 13 18 54 50 11 251 252 253 254 255 10 49 46 7];
origvals = unique(wm.data(:));
fprintf('\n[%s] Converting voxels... ',mfilename);
wmCounter=0;noWMCounter=0;
for ii = 1:length(origvals);
    if any(origvals(ii) == invals)
    wm.data( wm.data == origvals(ii) ) = 1;
    wmCounter=wmCounter+1;
        else
        wm.data( wm.data == origvals(ii) ) = 0;
        noWMCounter = noWMCounter + 1;
        end
    end
    fprintf('converted %i regions to White-matter (%i regions left outside of WM)\n\n',wmCounter,noWMCounter);
    niftiWrite(wm);
end
