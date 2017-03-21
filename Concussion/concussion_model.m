function concussion_model(subj)

dataOutputPath = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/Concussion_model/results/'];

%% Set the proper path for VISTASOFT 
vista_soft_path = '/N/dc2/projects/lifebid/code/vistasoft/';
addpath(genpath(vista_soft_path));

%% Set the proper path for the ENCODE with Concussion model
ENCODE_path = '/N/dc2/projects/lifebid/code/bacaron/encode/encode_concussion/';
addpath(genpath(ENCODE_path));

%% Concussion dataset 
dataRootPath = '/N/dc2/projects/lifebid/Concussion/concussion_test';
stem = 'data_b1000_aligned_trilin_noMEC';

% Generate fe_strucure
%% Build the file names for the diffusion data, the anatomical MRI.
dwiFile = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/data_b1000_aligned_trilin_noMEC.nii.gz'];
t1File = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/t1_acpc_bet.nii.gz'];
fgFileName = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/major_tracts/data_b1000_aligned_trilin_noMEC_ensemble.mat'];
feFileName    = strcat(subj,'_',stem,'_','ensemble','_','FE');
L = 360;

%% Fit the concussion model (Isotropic + Fibers + Microstructure)
load(['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/Concussion_model/results/fe_post_life.mat']);
fe_prob = feBuildDictionaries(fe_prob,L,L);
fit = feFit_iso_micro(feGet(fe_prob,'model'),feGet(fe_prob,'fiber weights'), feGet(fe_prob,'bvals'), feGet(fe_prob,'bvecs'), feGet(fe_prob,'s0_img'), feGet(fe_prob,'diffusionsignalinvoxel'));
fe_prob.life.fit.w0 = fit.w0;
fe_prob.life.fit.wa = fit.wa;
fe_prob.life.fit.Qa = fit.Qa;

save(['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/Concussion_model/results/fe_post_concussion.mat'], 'fe_prob', '-v7.3')
