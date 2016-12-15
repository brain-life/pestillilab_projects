function dtiinit_batch
% build paths
subj = { '1_5', '1_6' , '1_7' , '1_8', '1_9', '2_23', '2_26', '2_27', '2_28', '2_29', '3_44', '3_45', '3_49'};
b_vals = {'1000','2000'};
stem = 'data';
projdir1 = '/N/dc2/projects/lifebid/Concussion/concussion3';
for ii = 1:length(subj)
fprintf('\n Changing directory to \n %s \n',fullfile(projdir1,subj{ii}))
cd(fullfile(projdir1,subj{ii}))

% dtiinit
cd diffusion_data
cd 1000
dwParams = dtiInitParams
dwParams.rotateBvecsWithRx = 1
dwParams.rotateBvecsWithCanXform = 1
dwParams.bvecsFile = fullfile(projdir1,subj{ii},'diffusion_data','1000','raw','bvecs_real2')
dwParams.bvalsFile = fullfile(projdir1,subj{ii},'diffusion_data','1000','raw','bvals')
dwParams.eddyCorrect = -1
dwParams.dwOutMm = [2.0 2.0 2.0]
dwParams.phaseEncodeDir = 2
dwParams.outDir = fullfile(projdir1,subj{ii},'diffusion_data','1000')
[dt6FileName, outBaseDir] = dtiInit(fullfile(projdir1,subj{ii},'diffusion_data','1000','raw','data_b1000.nii.gz'), 't1_acpc_bet.nii.gz', dwParams)
cd ..
cd 2000
dwParams = dtiInitParams
dwParams.rotateBvecsWithRx = 1
dwParams.rotateBvecsWithCanXform = 1
dwParams.bvecsFile = fullfile(projdir1,subj{ii},'diffusion_data','2000','raw','bvecs')
dwParams.bvalsFile = fullfile(projdir1,subj{ii},'diffusion_data','2000','raw','bvals')
dwParams.eddyCorrect = -1
dwParams.dwOutMm = [2.0 2.0 2.0]
dwParams.phaseEncodeDir = 2
dwParams.outDir = fullfile(projdir1,subj{ii},'diffusion_data','2000')
[dt6FileName, outBaseDir] = dtiInit(fullfile(projdir1,subj{ii},'diffusion_data','2000','raw','data_b2000.nii.gz'), 't1_acpc_bet.nii.gz', dwParams)
end
