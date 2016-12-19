%% Script for segmenting fibers following mrtrix ensemble

% Read in fiber, set variables

rootpath = '/N/dc2/projects/lifebid/Concussion/concussion3';
subj = '1_5';
lmaxparam = {'2','4','6','8','10','12'};
numberparam = { '01', '02', '03', '04', '05', '06', '07','08','09','10'};
streamprob = {'PROB','STREAM'};
tensor = 'tensor';

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

