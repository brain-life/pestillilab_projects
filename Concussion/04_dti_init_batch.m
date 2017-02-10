function dti_init_batch
% function dti_init_batch
%
% Matlab script for running dtiInit script in batch form.  
% https://github.com/vistalab/vistasoft/blob/master/mrDiffusion/dtiInit/dtiInit.m
%
% 2017 Brad Caron Indiana University, Pestilli Lab

% build paths
% subjects for study
subj = '1_5';

% separate gradient shells
b_vals = {'1000','2000'}; 

% stem for data output
stem = 'data';

% path to study directory
projdir1 = '/N/dc2/projects/lifebid/Concussion/concussion_test'; 

% dtiinit params and function
for ii = 1:length(subj)
	for ibv = 1:length(b_vals)
	        % Set up dtiInit paramters specific for our study
		dwParams = dtiInitParams;
		dwParams.rotateBvecsWithRx = 1;
		dwParams.rotateBvecsWithCanXform = 1;
		dwParams.bvecsFile = fullfile(projdir1,sprintf('%s/diffusion_data/%s/raw/bvecs_real',subj{ii},b_vals{ibv}));
		dwParams.bvalsFile = fullfile(projdir1,sprintf('%s/diffusion_data/%s/raw/bvals',subj{ii},b_vals{ibv}));
		dwParams.eddyCorrect = -1;
		dwParams.dwOutMm = [2.0 2.0 2.0];
		dwParams.phaseEncodeDir = 2;
		dwParams.outDir = fullfile(projdir1,sprintf('%s/diffusion_data/%s',subj{ii},b_vals{ibv}));
		
		% Start Diffusion Imaging preprocessing.
		[dt6FileName, outBaseDir] = dtiInit(fullfile(projdir1,sprintf('%s/diffusion_data/%s/raw/data_b%s.nii.gz',subj{ii},b_vals{ibv},b_vals{ibv})), fullfile(projdir1,sprintf('%s/diffusion_data/%s/t1_acpc_bet.nii.gz',subj{ii},b_vals{ibv}),dwParams);
	end
end
exit;
