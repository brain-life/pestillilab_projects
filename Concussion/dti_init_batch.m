function dti_init_batch
% build paths
subj = '1_5';
b_vals = {'1000','2000'};
stem = 'data';
projdir1 = '/N/dc2/projects/lifebid/Concussion/concussion_test';
for ii = 1:length(subj)

% dtiinit
cd ./1000
dwParams = dtiInitParams;
dwParams.rotateBvecsWithRx = 1;
dwParams.rotateBvecsWithCanXform = 1;
dwParams.bvecsFile = fullfile(projdir1,subj,'diffusion_data','1000','raw','bvecs_real2a');
dwParams.bvalsFile = fullfile(projdir1,subj,'diffusion_data','1000','raw','bvals');
dwParams.eddyCorrect = -1;
dwParams.dwOutMm = [2.0 2.0 2.0];
dwParams.phaseEncodeDir = 2;
dwParams.outDir = fullfile(projdir1,subj,'diffusion_data','1000');
[dt6FileName, outBaseDir] = dtiInit(fullfile(projdir1,subj,'diffusion_data','1000','raw','data_b1000.nii.gz'), 't1_acpc_bet.nii.gz', dwParams);
cd ..
cd ./2000
dwParams = dtiInitParams;
dwParams.rotateBvecsWithRx = 1;
dwParams.rotateBvecsWithCanXform = 1;
dwParams.bvecsFile = fullfile(projdir1,subj,'diffusion_data','2000','raw','bvecs_real2a');
dwParams.bvalsFile = fullfile(projdir1,subj,'diffusion_data','2000','raw','bvals');
dwParams.eddyCorrect = -1;
dwParams.dwOutMm = [2.0 2.0 2.0];
dwParams.phaseEncodeDir = 2;
dwParams.outDir = fullfile(projdir1,subj,'diffusion_data','2000');
[dt6FileName, outBaseDir] = dtiInit(fullfile(projdir1,subj,'diffusion_data','2000','raw','data_b2000.nii.gz'), 't1_acpc_bet.nii.gz', dwParams);
end
exit;
