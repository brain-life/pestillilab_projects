function group_stats_tract_profile(bvals,fiberFile,tractNumber)

tract_labels = {'Left Thalamic Radiation', 'Right Thalamic Radiation', 'Left Corticospinal', 'Right Corticospinal', ...
                'Left Cingulum Cingulate', 'Right Cingulum Cingulate', 'Left Cingulum Hippocampus', 'Right Cingulum Hippocampus', ...
                'Callosum Forceps Major', 'Callosum Forceps Minor', 'Left IFOF', 'Right IFOF', 'Left ILF', 'Right ILF', 'Left SLF', ...
                'Right SLF', 'Left Uncinate', 'Right Uncinate', 'Left Arcuate', 'Right Arcuate'}

group1 = {'1_001', '1_002', '1_003', '1_005', '1_006', '1_007', '1_008', ...
        '1_009', '1_012', '1_013', '1_014', '1_015', '1_016', '1_017', ...
        '1_019', '1_020', '1_021'};
group2 = {'2_023', '2_026', '2_027', '2_028', '2_029', '2_030', '2_033', ...
          '2_034', '2_035', '2_036', '2_037', '2_038', '2_039', '2_040', ...
          '2_041'};
group3 = {'3_044', '3_045', '3_046', '3_049', '3_050', '3_052', '3_053', ...
          '3_054', '3_055'};

for ii = 1:length(group1)
    filePath = ['/N/dc2/projects/lifebid/Concussion/concussion_test/', group1{ii}, '/diffusion_data/', bvals, '/life/', fiberFile, '/stats_for_group_', num2str(tractNumber)];
    try
        group_1_data{ii} = load(filePath)
    catch ME
        display('error occurred...moving on')
    end
end

for ii = 1:length(group2)
    filePath = ['/N/dc2/projects/lifebid/Concussion/concussion_test/', group2{ii}, '/diffusion_data/', bvals, '/life/', fiberFile, '/stats_for_group_', num2str(tractNumber)];
    try
        group_2_data{ii} = load(filePath)
    catch ME
        display('error occurred...moving on')
    end
end

for ii = 1:length(group3)
    filePath = ['/N/dc2/projects/lifebid/Concussion/concussion_test/', group3{ii}, '/diffusion_data/', bvals, '/life/', fiberFile, '/stats_for_group_', num2str(tractNumber)];
    try
        group_3_data{ii} = load(filePath)
    catch ME
        display('error occurred...moving on')
    end
end

group_1_nonzero_cells = find(~cellfun(@isempty,group_1_data));
group_2_nonzero_cells = find(~cellfun(@isempty,group_2_data));
group_3_nonzero_cells = find(~cellfun(@isempty,group_3_data));

group_1_number_nonzero = numel(group_1_nonzero_cells);
group_2_number_nonzero = numel(group_2_nonzero_cells);
group_3_number_nonzero = numel(group_3_nonzero_cells);

group_1_sum_fa = 0;
for ii = 1:length(group1)
    try
        group_1_sum_fa = group_1_sum_fa + group_1_data{ii}.fa
    catch ME
        display('error occurred...moving on')
    end
end

group_1_sum_ad = 0;
for ii = 1:length(group1)
    try
        group_1_sum_ad = group_1_sum_ad + group_1_data{ii}.ad
    catch ME
        display('error occurred...moving on')
    end
end

group_1_sum_rd = 0;
for ii = 1:length(group1)
    try
        group_1_sum_rd = group_1_sum_rd + group_1_data{ii}.rd
    catch ME
        display('error occurred...moving on')
    end
end

group_1_sum_md = 0;
for ii = 1:length(group1)
    try
        group_1_sum_md = group_1_sum_md + group_1_data{ii}.md
    catch ME
        display('error occurred...moving on')
    end
end

group_2_sum_fa = 0;
for ii = 1:length(group2)
    try
        group_2_sum_fa = group_2_sum_fa + group_2_data{ii}.fa
    catch ME
        display('error occurred...moving on')
    end
end

group_2_sum_ad = 0;
for ii = 1:length(group2)
    try
        group_2_sum_ad = group_2_sum_ad + group_2_data{ii}.ad
    catch ME
        display('error occurred...moving on')
    end
end

group_2_sum_rd = 0;
for ii = 1:length(group2)
    try
        group_2_sum_rd = group_2_sum_rd + group_2_data{ii}.rd
    catch ME
        display('error occurred...moving on')
    end
end

group_2_sum_md = 0;
for ii = 1:length(group2)
    try
        group_2_sum_md = group_2_sum_md + group_2_data{ii}.md
    catch ME
        display('error occurred...moving on')
    end
end
group_3_sum_fa = 0;
for ii = 1:length(group3)
    try
        group_3_sum_fa = group_3_sum_fa + group_3_data{ii}.fa
    catch ME
        display('error occurred...moving on')
    end
end

group_3_sum_ad = 0;
for ii = 1:length(group3)
    try
        group_3_sum_ad = group_3_sum_ad + group_3_data{ii}.ad
    catch ME
        display('error occurred...moving on')
    end
end

group_3_sum_rd = 0;
for ii = 1:length(group3)
    try
        group_3_sum_rd = group_3_sum_rd + group_3_data{ii}.rd
    catch ME
        display('error occurred...moving on')
    end
end

group_3_sum_md = 0;
for ii = 1:length(group3)
    try
        group_3_sum_md = group_3_sum_md + group_3_data{ii}.md
    catch ME
        display('error occurred...moving on')
    end
end

group_1_avg_fa = group_1_sum_fa / numel(group_1_nonzero_cells);
group_2_avg_fa = group_2_sum_fa / numel(group_2_nonzero_cells);
group_3_avg_fa = group_3_sum_fa / numel(group_3_nonzero_cells);

group_1_avg_ad = group_1_sum_ad / numel(group_1_nonzero_cells);
group_1_max_ad = max(group_1_avg_ad);
group_2_avg_ad = group_2_sum_ad / numel(group_2_nonzero_cells);
group_2_max_ad = max(group_2_avg_ad);
group_3_avg_ad = group_3_sum_ad / numel(group_3_nonzero_cells);
group_3_max_ad = max(group_3_avg_ad);
max_ad_groups = {group_1_max_ad, group_2_max_ad, group_3_max_ad};
max_ad = max([max_ad_groups{:}]);
max_ad_plus_one = max_ad + 1;

group_1_avg_rd = group_1_sum_rd / numel(group_1_nonzero_cells);
group_1_max_rd = max(group_1_avg_rd);
group_2_avg_rd = group_2_sum_rd / numel(group_2_nonzero_cells);
group_2_max_rd = max(group_2_avg_rd);
group_3_avg_rd = group_3_sum_rd / numel(group_3_nonzero_cells);
group_3_max_rd = max(group_3_avg_rd);
max_rd_groups = {group_1_max_rd, group_2_max_rd, group_3_max_rd};
max_rd = max([max_rd_groups{:}]);
max_rd_plus_one = max_rd + 1;

group_1_avg_md = group_1_sum_md / numel(group_1_nonzero_cells);
group_2_avg_md = group_2_sum_md / numel(group_2_nonzero_cells);
group_3_avg_md = group_3_sum_md / numel(group_3_nonzero_cells);

% plot fa
		nodesToPlot = 50:151;

		h.tpfig = figure('name', 'My tract profile','color', 'w', 'visible', 'off');
        group_1_tract_profile_fa = plot(group_1_avg_fa(nodesToPlot),'color', [0.9 0.2 0.2],'linewidth',4); hold on;
        group_2_tract_profile_fa = plot(group_2_avg_fa(nodesToPlot),'color', [0.2 0.9 0.2],'linewidth',4); hold on;
        group_3_tract_profile_fa = plot(group_3_avg_fa(nodesToPlot),'color', [0.2 0.2 0.9],'linewidth',4); hold off;
        h_legend = legend(sprintf('group 1 = %s/%s',num2str(group_1_number_nonzero),num2str(numel(group1))), sprintf('group 2 = %s/%s',num2str(group_2_number_nonzero),num2str(numel(group2))), sprintf('group 3 = %s/%s',num2str(group_3_number_nonzero),num2str(numel(group3))), 'Location', 'best')
        set(h_legend,'FontSize',8);
        set(gca, 'fontsize',20, 'box','off', 'TickDir','out', ...
    			'xticklabel',{'Tract begin','Tract end'},'xlim',[0 100],'ylim',[0.00 1.00],'Ytick',[0 .25 .5 .75],'Xtick',[0 100])
		Title_plot = title(sprintf('%s FA', tract_labels{tractNumber}))
		xlabel('Location on tract')
		ylh = ylabel('Fractional Anisotropy');
        saveas(h.tpfig, ['/N/dc2/projects/lifebid/Concussion/concussion_test/results/', bvals, '/', fiberFile, '/', Title_plot.String], 'png');
        
% plot ad
		nodesToPlot = 50:151;

		h.tpfig = figure('name', 'My tract profile','color', 'w', 'visible', 'off');
        group_1_tract_profile_ad = plot(group_1_avg_ad(nodesToPlot),'color', [0.9 0.2 0.2],'linewidth',4); hold on;
        group_2_tract_profile_ad = plot(group_2_avg_ad(nodesToPlot),'color', [0.2 0.9 0.2],'linewidth',4); hold on;
        group_3_tract_profile_ad = plot(group_3_avg_ad(nodesToPlot),'color', [0.2 0.2 0.9],'linewidth',4); hold off;
        h_legend = legend(sprintf('group 1 = %s/%s',num2str(group_1_number_nonzero),num2str(numel(group1))), sprintf('group 2 = %s/%s',num2str(group_2_number_nonzero),num2str(numel(group2))), sprintf('group 3 = %s/%s',num2str(group_3_number_nonzero),num2str(numel(group3))), 'Location', 'best')
        set(h_legend,'FontSize',8);
        set(gca, 'fontsize',20, 'box','off', 'TickDir','out', ...
    			'xticklabel',{'Tract begin','Tract end'},'xlim',[0 100],'ylim',[0.00 2.00],'Ytick',[0 .25 .5 .75 1.0 1.25 1.5 1.75 2.0],'Xtick',[0 100])
		Title_plot = title(sprintf('%s AD', tract_labels{tractNumber}))
		xlabel('Location on tract')
		ylh = ylabel('Axial Diffusivity');
        saveas(h.tpfig, ['/N/dc2/projects/lifebid/Concussion/concussion_test/results/', bvals, '/', fiberFile, '/', Title_plot.String], 'png');
        
% plot rd
		nodesToPlot = 50:151;
        
		h.tpfig = figure('name', 'My tract profile','color', 'w', 'visible', 'off');
        group_1_tract_profile_rd = plot(group_1_avg_rd(nodesToPlot),'color', [0.9 0.2 0.2],'linewidth',4); hold on;
        group_2_tract_profile_rd = plot(group_2_avg_rd(nodesToPlot),'color', [0.2 0.9 0.2],'linewidth',4); hold on;
        group_3_tract_profile_rd = plot(group_3_avg_rd(nodesToPlot),'color', [0.2 0.2 0.9],'linewidth',4); hold off;
        h_legend = legend(sprintf('group 1 = %s/%s',num2str(group_1_number_nonzero),num2str(numel(group1))), sprintf('group 2 = %s/%s',num2str(group_2_number_nonzero),num2str(numel(group2))), sprintf('group 3 = %s/%s',num2str(group_3_number_nonzero),num2str(numel(group3))), 'Location', 'best')
        set(h_legend,'FontSize',8);
        set(gca, 'fontsize',20, 'box','off', 'TickDir','out', ...
    			'xticklabel',{'Tract begin','Tract end'},'xlim',[0 100],'ylim',[0.00 max_rd_plus_one],'Ytick',[0 .25 .5 .75 1.00 1.25 1.50 1.75 2.0],'Xtick',[0 100])
		Title_plot = title(sprintf('%s RD', tract_labels{tractNumber}))
		xlabel('Location on tract')
		ylh = ylabel('Radial Diffusivity');
        saveas(h.tpfig, ['/N/dc2/projects/lifebid/Concussion/concussion_test/results/', bvals, '/', fiberFile, '/', Title_plot.String], 'png');
  
% plot md
		nodesToPlot = 50:151;

		h.tpfig = figure('name', 'My tract profile','color', 'w', 'visible', 'off');
        group_1_tract_profile_md = plot(group_1_avg_md(nodesToPlot),'color', [0.9 0.2 0.2],'linewidth',4); hold on;
        group_2_tract_profile_md = plot(group_2_avg_md(nodesToPlot),'color', [0.2 0.9 0.2],'linewidth',4); hold on;
        group_3_tract_profile_md = plot(group_3_avg_md(nodesToPlot),'color', [0.2 0.2 0.9],'linewidth',4); hold off;
        h_legend = legend(sprintf('group 1 = %s/%s',num2str(group_1_number_nonzero),num2str(numel(group1))), sprintf('group 2 = %s/%s',num2str(group_2_number_nonzero),num2str(numel(group2))), sprintf('group 3 = %s/%s',num2str(group_3_number_nonzero),num2str(numel(group3))), 'Location', 'best')
        set(h_legend,'FontSize',8);
        set(gca, 'fontsize',20, 'box','off', 'TickDir','out', ...
    			'xticklabel',{'Tract begin','Tract end'},'xlim',[0 100],'ylim',[0 2.00],'Ytick',[0 .25 .5 .75 1.0 1.25 1.5 1.75 2.0 2.25 2.5 2.75 3.],'Xtick',[0 100])
		Title_plot = title(sprintf('%s MD', tract_labels{tractNumber}))
		xlabel('Location on tract')
		ylh = ylabel('Mean Diffusivity');
        saveas(h.tpfig, ['/N/dc2/projects/lifebid/Concussion/concussion_test/results/', bvals, '/', fiberFile, '/', Title_plot.String], 'png')
clear()
