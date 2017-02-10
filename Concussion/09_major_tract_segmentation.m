clear fe;
save(['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/life/optimized_life_connectome_1'], 'fg', '-v7.3');

% AFQ
dtFile = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/dti64trilin/dt6.mat'];
wholeBrainConnectome = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/life/optimized_life_connectome_1.mat'];
[fascicles,classification,fg,fg_classified] = feAfqSegment(dtFile, wholeBrainConnectome);
save(['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/life/post_afq_fg'], 'fg', 'fg_classified', 'classification', 'fascicles', '-v7.3');
