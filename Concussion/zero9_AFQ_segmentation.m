function zero9_AFQ_semgentation(subj)
% This function will run Automated Fiber Quantification (Yeatman et al, 2014; https://github.com/yeatmanlab/AFQ). It will take
% the LiFE-evaluated ensemble connectome and segment streamlines into 20 major fiber tracts.
%
% Input is subject name.
%
% Output is a post_life_afq_fg.mat file that will contain fg, fg_classified, classification, and fascicles structures.  Fg_classified
% holds the major tracts, and will be used to generate tract profiles.
%
% 2017 Brad Caron Indiana University, Pestilli Lab

% AFQ
% These file structures will need to be changed for your file set-up.
dtFile = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/dti64trilin/dt6.mat'];
wholeBrainConnectome = ['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/life/optimized_life_connectome_1.mat'];
[fascicles,classification,fg,fg_classified] = feAfqSegment(dtFile, wholeBrainConnectome);
save(['/N/dc2/projects/lifebid/Concussion/concussion_test/' subj '/diffusion_data/1000/life/post_afq_fg'], 'fg', 'fg_classified', 'classification', 'fascicles', '-v7.3');
