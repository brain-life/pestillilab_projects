% Organize folders and files for the HCP 7T data
% 
% Also, load a series of BVECS/BVALS files in FSL/VISTASOFT format and write them
% write them down to disk as MRTRIX .b files.
%
% Also, load an original HCP 7T data set and save it down to disk as separate
% files, a 1000 Bval file and a 2000 bval file.

% build paths
subj = { '102311','108323','109123','131217','158035', ...
         '200614','352738','573249','770352','910241'};
b_vals = {'1000','2000'};
stem = 'data';
projdir = '/N/dc2/projects/lifebid/HCP7/';

for ii = 1:length(subj)
fprintf('\n Changing directory to \n %s \n',fullfile(projdir,subj{ii}))
cd(fullfile(projdir,subj{ii}))

% Organize folders
!mkdir-v original_hcp_data
!mv -v T1w/* original_hcp_data/
!mkdir -v anatomy
!cp -v original_hcp_data/*nii.gz* anatomy/
!mkdir -v fibers
!mkdir -v diffusion_data
!cp -v original_hcp_data/Diffusion7T/* diffusion_data/

% Split data into two separate files (BVALS = 1000 and 2000).
bvals = dlmread('data.bvals');
dwi   = niftiRead('data.nii.gz');
dwi1000 = dwi;
dwi1000.fname = 'data_b1000.nii.gz';

dwi2000 = dwi;
dwi2000.fname = 'data_b2000.nii.gz';
index1000 = (bvals == 1000);
index2000 = (bvals == 2000);
index0    = (bvals == 0);

% Find all indices to each bvalue and B0
all_1000  = or(index1000,index0);
all_2000  = or(index2000,index0);

dwi1000.data = dwi.data(:,:,:,all_1000);
dwi1000.dim(4) = size(dwi1000.data,4);
niftiWrite(dwi1000);
bvals1000 = bvals(all_1000);
dlmwrite('data_b1000.bvals',bvals1000);
bvecs1000 = dlmread('data.bvecs');
bvecs1000 = bvecs1000(:,all_1000);
dlmwrite('data_b1000.bvecs',bvecs1000);

dwi2000.data = dwi.data(:,:,:,all_2000);
dwi2000.dim(4) = size(dwi2000.data,4);
niftiWrite(dwi2000);
bvals2000 = bvals(all_2000);
dlmwrite('data_b2000.bvals',bvals2000);
bvecs2000 = dlmread('data.bvecs');
bvecs2000 = bvecs2000(:,all_2000);
dlmwrite('data_b2000.bvecs',bvecs2000);

for ibv = 1:length(b_vals)
    bvecs = fullfile(projdir, subj{ii}, 'diffusion_data', sprintf('data_b%s.bvecs',b_vals{ibv}));
    bvals = fullfile(projdir, subj{ii}, 'diffusion_data', sprintf('data_b%s.bvals',b_vals{ibv}));
    out   = fullfile(projdir, subj{ii}, 'fibers',         sprintf('data_b%s.b',    b_vals{ibv}));
    mrtrix_bfileFromBvecs(bvecs, bvals, out);
end
end
