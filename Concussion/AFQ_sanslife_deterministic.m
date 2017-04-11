function AFQ_sanslife_deterministic(subj,bvals)
% This function will run Automated Fiber Quantification (Yeatman et al, 2014; https://github.com/yeatmanlab/AFQ). It will take
% the deterministic ensemble connectome and segment streamlines into 20 major fiber tracts.
%
% Input is subject name and bvals.
%
% Output is a post_life_afq_fg.mat file that will contain fg, fg_classified, classification, and fascicles structures.  Fg_classified
% holds the major tracts, and will be used to generate tract profiles.
%
% 2017 Brad Caron Indiana University, Pestilli Lab
% AFQ
dtFile = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/' bvals '/dti64trilin/dt6.mat'];
wholeBrainConnectome = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/' bvals '/major_tracts/' sprintf('data_b%s_aligned_trilin_noMEC_deterministic_ensemble.mat',bvals)];
[fascicles,classification,fg,fg_classified] = feAfqSegment(dtFile, wholeBrainConnectome);
save(['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/' bvals '/life/post_afq_fg_sanslife_deterministic'], 'fg', 'fg_classified', 'classification', 'fascicles', '-v7.3')
