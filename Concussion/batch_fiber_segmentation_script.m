%% Script for segmenting fibers following mrtrix ensemble.  Developed by Franco Pestilli (2016); script compiled by Brad Caron (IU Grad student, 2016) used in microstructure of concussion-prone athletics study. Script designed for use in matlab.

% Read in fiber, set variables

rootpath = '/N/dc2/projects/lifebid/Concussion/concussion3'; % Data directory path
subj = '1_5'; % Subject; include all subjects for batch
lmaxparam = {'2','4','6','8','10','12'}; % lmax parameters from mrtrix ensemble
numberparam = { '01', '02', '03', '04', '05', '06', '07','08','09','10'}; % number parameter from mrtrix ensemble
streamprob = {'PROB','STREAM'}; % probability or strealine from mrtrix ensemble
tensor = 'tensor'; % tensor model

for ilm = 1:length(lmaxparam)
	for inm = 1:length(numberparam)
		fe_path = fullfile(rootpath, subj, 'diffusion_data/1000');
            	fg = fgRead(fullfile(fe_path,'fibers_new',sprintf('data_b1000_aligned_trilin_wm_tensor-NUM%s-500000.tck',numberparam{inm})));
            	dt6File = fullfile(fe_path,'/dti64trilin/dt6.mat');
		fasciclesClassificationSaveName = fullfile(fe_path,'major_tracts', sprintf('data_b1000_aligned_trilin_wm_tensor-NUM%s_500000.mat',numberparam{inm}));
			for isp = 1:length(streamprob)
				fe_path = fullfile(rootpath, subj, 'diffusion_data/1000');
            			fg = fgRead(fullfile(fe_path,'fibers_new',sprintf('data_b1000_aligned_trilin_csd_lmax%s_wm_SD_%s-NUM%s-500000.tck',lmaxparam{ilm},streamprob{isp},numberparam{inm})));
            			dt6File = fullfile(fe_path,'/dti64trilin/dt6.mat');
	    			fasciclesClassificationSaveName = fullfile(fe_path,'major_tracts', sprintf('data_b1000_aligned_trilin_csd_lmax%s_wm_SD_%s_NUM%s_500000.mat',lmaxparam{ilm},streamprob{isp},numberparam{inm}));
	    	
	    		

% Find the major tracts
disp('Segment tracts...')
[fg_classified,~,classification]= AFQ_SegmentFiberGroups(dt6File, fg);
fascicles = fg2Array(fg_classified);
clear fg
disp('Save results to disk...')
save(fasciclesClassificationSaveName,'fg_classified','classification','fascicles','-v7.3')
fprintf('\n\n\n Saved file: \n%s \n\n\n',fasciclesClassificationSaveName)
    			end
	end
end

