function post_tracking_pipeline_fxn_new_test(subj, cacheDir)

anatomyFile = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/t1_acpc_bet.nii.gz'];
feFileName = 'data_b1000_aligned_trilin_noMEC_ensemble_FE';
dwiFile = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/data_b1000_aligned_trilin_noMEC.nii.gz'];
fgFileName = 'data_b1000_aligned_trilin_noMEC_ensemble.mat';
fe_path = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj 'diffusion_data/1000'];
dwiFileRepeated = [];
savedir = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/life'];

% Build the life model into an fe structure
L = 360; % Discretization parameter
fe = feConnectomeInit(dwiFile,fgFileName,feFileName,savedir,dwiFileRepeated,anatomyFile,L,[1,0]);

% Fit the model.
Niter = 500;
fit = feFitModel(feGet(fe,'model'),feGet(fe,'dsigdemeaned'),'bbnnls',Niter,'preconditioner');

% Install the fit to the FE structure
fe = feSet(fe,'fit',fit);
% Save the life model to disk
save(['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/life/optimized_life_1'], 'fe', '-v7.3');

% Extract the fascicles with positive weight
w  = feGet(fe,'fiber weights'); % Collect the weights associated with each fiber
fg = feGet(fe,'fibers acpc');
fg = fgExtract(fg,w > 0);

clear fe;
save(['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/life/optimized_life_connectome_1'], 'fg', '-v7.3');

% AFQ
dtFile = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/dti64trilin/dt6.mat'];
wholeBrainConnectome = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/life/optimized_life_connectome_1.mat'];
[fascicles,classification,fg,fg_classified] = feAfqSegment(dtFile, wholeBrainConnectome);
save(['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/life/post_afq_fg'], 'fg', 'fg_classified', 'classification', 'fascicles', '-v7.3');


end
