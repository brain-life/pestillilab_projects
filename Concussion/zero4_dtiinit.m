function dti_init_batch(subj,bvals,projdir1)
%
% This function will run dtiinit preprocessing. 
% https://github.com/vistalab/vistasoft/blob/master/mrDiffusion/dtiInit/dtiInit.m
%
% The inputs are the subjects (subj), b-values (bvals), and the project directory
% (projdir1).  These need to be inputted in function line.  See below for example input.
%
% The ouput of interest, dt6.mat, will be outputted to the project directory in a newly created folder called 'dti(number of
% diffusion directions)trilin'. dt6.mat file will be used in later steps of pipeline.
%
% 2017 Brad Caron Indiana University, Pestilli Lab

% build paths; these will need to be inputted into function
% subjects for study
% subj = '1_5';

% b-values for study
% bvals = {'1000','2000'}; 

% project directory for study
% projdir1 = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/' bvals];

% dtiinit params and function
cd(projdir1)
dwParams = dtiInitParams;
dwParams.rotateBvecsWithRx = 1;
dwParams.rotateBvecsWithCanXform = 1;
dwParams.bvecsFile = fullfile(projdir1,'raw','bvecs_real');
dwParams.bvalsFile = fullfile(projdir1,'raw','bvals');
dwParams.eddyCorrect = -1;
dwParams.dwOutMm = [2.0 2.0 2.0];
dwParams.phaseEncodeDir = 2;
dwParams.outDir = fullfile(projdir1);
[dt6FileName, outBaseDir] = dtiInit(sprintf('data_b%s.nii.gz', bvals), 't1_acpc_bet.nii.gz', dwParams)
exit;
