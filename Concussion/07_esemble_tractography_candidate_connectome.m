function batch_fiber_segmentation
% Script for segmenting fibers following mrtrix ensemble.  
%
% BRAD WRITE HEADER
%
% Developed by Franco Pestilli (2016); 
% script compiled by Brad Caron (IU Grad student, 2016) used in microstructure of concussion-prone athletics study. Script designed for use in matlab.

% Number of fiber tousefrom eahc individual connectome
n = 60000;

% Read in fiber, set variables
rootpath = '/N/dc2/projects/lifebid/Concussion/concussion_test'; % Data directory path
subj = {'1_003', '1_005', '1_006', '1_007', '1_008', '1_009', '1_012', ...
        '1_013', '1_014', '1_015', '1_016', '1_017', '1_019', '1_020', '1_021'}; % Subject; include all subjects for batch
lmaxparam = {'2','4','6','8','10','12'}; % lmax parameters from mrtrix ensemble
streamprob = {'PROB','STREAM'}; % probability or strealine from mrtrix ensemble

for ii = 1:length(subj)
% Tensor-based tracking. only on fascicles group
         fe_path = fullfile(rootpath, subj{ii}, 'diffusion_data/1000');
         fg = fgRead(fullfile(fe_path,'fibers_new',sprintf('data_b1000_aligned_trilin_noMEC_wm_tensor-500000.tck')));
         dt6File = fullfile(fe_path,'/dti64trilin/dt6.mat');
         fasciclesClassificationSaveName = fullfile(fe_path,'major_tracts', sprintf('data_b1000_aligned_trilin_noMEC_wm_tensor-500000.mat'));

	% Subsample the fascicles 500,000 are too many (eliminate this step in the future by reducing the number of fascicles you track, track 60,000 fascicles max for 13 tractography methods and 100,000x70 data points).
	fgIdx = randsample(1:length(fg.fibers),n);
	fg = fgExtract(fg,fgIdx,'keep');

	% CSD-based tracking. Load one at the time.
	for ilm = 1:length(lmaxparam)
			for isp = 1:length(streamprob)
				fe_path = fullfile(rootpath, subj{ii}, 'diffusion_data/1000');
            			fg_tmp = fgRead(fullfile(fe_path,'fibers_new',sprintf('data_b1000_aligned_trilin_noMEC_csd_lmax%s_wm_SD_%s-500000.tck',lmaxparam{ilm},streamprob{isp})));
                                fgIdx = randsample(1:length(fg_tmp.fibers),n);
                                fg_tmp = fgExtract(fg_tmp,fgIdx,'keep');

                                % Merge the new fiber group with the original fiber group.
                                fg = fgMerge(fg,fg_tmp);
                                clear fg_tmp
			end

	% Write fascicle group to disk.
	fgFileName = fullfile(fe_path, 'major_tracts', sprintf('data_b1000_aligned_trilin_noMEC_csd_lmax%s_plus_tensor-60000.mat',lmaxparam{ilm});
	fgWrite(fg,fgFileName);
	clear fg
	end
end
