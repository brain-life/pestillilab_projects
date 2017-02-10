function dti_init_batch

%% Matlab script for running dti_init script in batch form.  dti_init developed by Vistalab (Stanford University; 2014), found in software package vistasoft (https://github.com/brain-life/vistasoft).  Script for init params compiled by Brad Caron (IU Graduate Student, 2016) and used in microstructure of concussion-prone athletics study.

% build paths
subj = '1_5'; % subjects for study
b_vals = {'1000','2000'}; % separate gradient shells
stem = 'data'; % stem for data output
projdir1 = '/N/dc2/projects/lifebid/Concussion/concussion_test'; % path to study directory

% dtiinit params and function
for ii = 1:length(subj)
	for ibv = 1:length(b_vals)
		dwParams = dtiInitParams;
		dwParams.rotateBvecsWithRx = 1;
		dwParams.rotateBvecsWithCanXform = 1;
		dwParams.bvecsFile = fullfile(projdir1,sprintf('%s/diffusion_data/%s/raw/bvecs_real',subj{ii},b_vals{ibv}));
		dwParams.bvalsFile = fullfile(projdir1,sprintf('%s/diffusion_data/%s/raw/bvals',subj{ii},b_vals{ibv}));
		dwParams.eddyCorrect = -1;
		dwParams.dwOutMm = [2.0 2.0 2.0];
		dwParams.phaseEncodeDir = 2;
		dwParams.outDir = fullfile(projdir1,sprintf('%s/diffusion_data/%s',subj{ii},b_vals{ibv}));
		[dt6FileName, outBaseDir] = dtiInit(fullfile(projdir1,sprintf('%s/diffusion_data/%s/raw/data_b%s.nii.gz',subj{ii},b_vals{ibv},b_vals{ibv})), fullfile(projdir1,sprintf('%s/diffusion_data/%s/t1_acpc_bet.nii.gz',subj{ii},b_vals{ibv}),dwParams);
	end
end
exit;
