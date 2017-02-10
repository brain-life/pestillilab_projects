function zero_8_connectome_evaluation(subj, cacheDir)

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
fg = fgExtract(fg, w > 0);
save(['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/life/optimized_life_connectome_1'], 'fg', '-v7.3');

end
