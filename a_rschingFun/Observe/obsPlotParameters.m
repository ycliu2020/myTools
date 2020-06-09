function [mlabels, areaNum] = obsPlotParameters(p_1, p_2, p_3)
    % By liuyincheng (ycliu@smail.nju.edu.cn)
    % purpose: auto output plot parameters, so we only need to modify once if something change.
    % eg:[mlabels, areaNum] = plotParameters('toa', 'land','cld-clr')
    %
    % p_1: input, determine 'SFC', 'TOA', 'ATM(TOA-SFC)'
    % p_2: input, determine 'landSea' or 'land','china'
    % p_3: input, determine 'ERAi' or 'CERES','MODIS'


    %% commom labels
    level_label = {'SFC', 'TOA', 'ATM(TOA-SFC)'}; % plot which level to plot
    dataname = {'ERAi', 'CERES', 'MODIS'};

    mlabels.month = {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};
    mlabels.season = {'MAM', 'JJA', 'SON', 'DJF'};
    mlabels.unite = {' trend(W\cdotm-2/10a)',' trend(W\cdotm-2/10a)', ...
        ' trend(W\cdotm-2/10a)',' trend(W\cdotm-2/10a)', ...
        ' trend(W\cdotm-2/10a)',' trend(W\cdotm-2/10a)'};
    mlabels.component = {'Ts radeffect', 'RHeating radiation', ...
        'Cloud radeffect', 'Ta radeffect', ...
        'q radeffect', 'albedo radeffect'};%3*2
    if strcmp(p_3, 'ERAi') == 1 || strcmp(p_3, 'erai') == 1

        if mean(p_1 == 1) == 1 || strcmp(p_1, 'SFC') == 1 || strcmp(p_1, 'sfc') == 1
            p_1 = 1;
            %% specific labels
            mlabels.componentNames = {'dRsfc_ts', 'drhs', ...
                'dRsfc_cloud', 'dRsfc_ta', ...
                'dRsfc_q', 'dRsfc_alb'};

        elseif mean(p_1 == 2) == 1 || strcmp(p_1, 'TOA') == 1 || strcmp(p_1, 'toa') == 1
            p_1 = 2;
            %% specific labels
            mlabels.componentNames = {'dRtoa_ts', 'drhs', ...
                'dRtoa_cloud', 'dRtoa_ta', ...
                'dRtoa_q', 'dRtoa_alb'};
        end

    elseif strcmp(p_3, 'CERES') == 1 || strcmp(p_3, 'ceres') == 1
        if mean(p_1 == 1) == 1 || strcmp(p_1, 'SFC') == 1 || strcmp(p_1, 'sfc') == 1
            p_1 = 1;
            %% specific labels
            mlabels.componentNames = {'dRsfc_ts', 'CErhs', ...
                'dRsfc_cloud', 'dRsfc_ta', ...
                'dRsfc_q', 'dRsfc_alb'};

        elseif mean(p_1 == 2) == 1 || strcmp(p_1, 'TOA') == 1 || strcmp(p_1, 'toa') == 1
            p_1 = 2;
            %% specific labels
            mlabels.componentNames = {'dRtoa_ts', 'CErhs', ...
                'dRtoa_cloud', 'dRtoa_ta', ...
                'dRtoa_q', 'dRtoa_alb'};
        end
    end

    mlabels.vars = strcat('trendyr_', mlabels.componentNames);
    mlabels.level = level_label{p_1};

    if mean(p_2 == 0)==1 || strcmp(p_2, 'land sea') == 1 || strcmp(p_2, 'landSea') == 1 || strcmp(p_2, 'landsea') == 1
        areaNum = 0;
        mlabels.area = 'landSea';
    elseif mean(p_2 == 1)==1 || strcmp(p_2, 'land') == 1
        areaNum = 1;
        mlabels.area = 'land';
    elseif mean(p_2 == 2)==1 || strcmp(p_2, 'china') == 1
        areaNum = 2;
        mlabels.area = 'china';
    end

end
