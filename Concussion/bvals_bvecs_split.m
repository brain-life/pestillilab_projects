function bvals_bvecs_split(subj,bvals,projdir1)

% Matlab script for splitting shells and generating data, bvec and bval files for each shell in multi-shell data. 
% Script developed by Franco Pestilli (2014).
%
% 2017 Brad Caron Indiana University, Pestilli Lab.

% File structure for "Effect of long-term participation in high-impact sport" (Caron et al, 2017; in prep) study.
% These three lines can be removed, but will need to be added to the matlab command line of the zero2_bvalss_bvecs_split 
% script (github.com/brain-life/pestillilab_projects/Concussion/zero2_bvecs_bvals_split)
subj = '1_5'; % subject; add all subjects for batch
bvals = {'1000','2000'}; % separate shells
projdir1 = '/N/dc2/projects/lifebid/Concussion/concussion_test'; % path to data directory

% Split data into two separate files (BVALS = 1000 and 2000).

bvals = dlmread('data.bvals');
bvals = round(bvals./100)*100;
bvals(bvals==100) = 0;
dlmwrite('data.bvals',bvals)
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

% Create .b file needed for mrtrix tracking
for ibv = 1:length(bvals)
bvecs = fullfile(projdir1, subj, 'diffusion_data', sprintf('data_b%s.bvecs',bvals{ibv}));
bvals = fullfile(projdir1, subj, 'diffusion_data', sprintf('data_b%s.bvals',bvals{ibv}));
out   = fullfile(projdir1, subj, 'diffusion_data', 'fibers', sprintf('data_b%s.b', b_vals{ibv}));
mrtrix_bfileFromBvecs(bvecs, bvals, out);
end
exit;
