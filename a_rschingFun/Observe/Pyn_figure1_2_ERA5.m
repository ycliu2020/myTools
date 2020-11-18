%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-08-31 17:00:15
% LastEditTime : 2020-11-16 22:29:04
% LastEditors  : LYC
% Description  : 同时画时间序列和相关性分布图
% FilePath     : /code/p1_processObserveData/ERA5/timeSeriAnalysis/Pyn_figure1_2_ERA5.m
%
%%---------------------------------------------------------
function [lon_f,lat_f,cc_global,headLineTxt,figPath,colorLab] = Pyn_figure1_2_ERA5(exmNum)
    % load mask map
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_cp144.mat')% load word land mask
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_ce72.mat')% load word land mask
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/correct_worldmap.mat')
    load('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/mat_file/mask14472.mat')
    [mlabels, ~] = obsPlotParameters('sfc', 'land', 'ERA5-radEffect-ts');
    [readme, level, tLin, vars] = obsParameters('ERA5');
    
    latRange = 90; % Latitude range
    lon1 = [2.5 357.5]; lat1 = [-latRange + 1 latRange - 1]; % world area
    toaSfc = {'toa', 'sfc'};
    lon_k = 0:2.5:357.5; nlonk = length(lon_k); % kernel lat lon
    lat_k = 90:-2.5:-90; nlatk = length(lat_k);
    lat_f = 88.75:-2.5:-88.75; nlatf = length(lat_f); % figure lat lon
    lon_f = lon_k; nlonf = length(lon_f);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %read data
    varsPath = fullfile('/data1/liuyincheng/Observe-process', tLin.time{exmNum}, 'ERA5', level.standVarPath{1}); %rawdata
    dvarsPath = fullfile('/data1/liuyincheng/Observe-process', tLin.time{exmNum}, 'ERA5', level.standVarPath{2}); %anomaly
    dvarsTrendPath = fullfile('/data1/liuyincheng/Observe-process', tLin.time{exmNum}, 'ERA5', level.standVarPath{3}); %anomaly_trend
    kernelCalPath = fullfile('/data1/liuyincheng/Observe-process', tLin.time{exmNum}, 'ERA5', level.standVarPath{4}); % kernelCal
    radEfectPath = fullfile('/data1/liuyincheng/Observe-process', tLin.time{exmNum}, 'ERA5', level.standVarPath{5}); %radEffect
    dradTrendPath = fullfile('/data1/liuyincheng/Observe-process', tLin.time{exmNum}, 'ERA5', level.standVarPath{6}); %/data1/liuyincheng/cmip6-proces/aimp_2000-2014/MRI-ESM2-0/ensemble/radEffect_trend/
    outPutPath = fullfile('/home/liuyc/Research/P02.Ts_change_research/figure/proj1_Observe/TimeSeries_analysis/', ['ERA5_', tLin.time{exmNum}]);
    auto_mkdir(outPutPath)
    load([dvarsTrendPath, 'global_vars.mat'])%% 'lon_f', 'lat_f', 'lon_k', 'lat_k', 'plev_k', 'time'
    load([radEfectPath, 'dradEfect_sfc_cld.mat'])% load albEffect, husEffect, mainEffect, taEffect, taOnlyEffect, taOnlyEffect2, tasEffect, tasEffect2, totalEffect, tsEffect, wvlwEffect, wvswEffect
    load([dvarsPath, 'drhs.mat'])% load drhs
    nlonf = length(lon_f);
    nlatf = length(lat_f);
    ntime = length(time);
    % regrid
    drhs = autoRegrid3(lon_k, lat_k, time, drhs, lon_f, lat_f, time);

    varUsed = zeros(nlonf, nlatf, ntime, 2);
    varUsed(:, :, :, 1) = tsEffect;
    varUsed(:, :, :, 2) = drhs;
    varNames = {'dR_{Ts}', 'dRHeating', 'ta RadEfect', 'ts RadEfect', 'q RadEfect', 'alb RadEfect'};
    yLabel = {'W/m2', 'W/m2', 'W/m2', 'W/m2', 'W/m2', 'W/m2'};

    sizeVarUsed = size(varUsed);
    sizeLon = sizeVarUsed(1); sizeLat = sizeVarUsed(2); sizeTime = sizeVarUsed(3); sizeVar = sizeVarUsed(4);
    varUsedYearly = zeros(sizeLon, sizeLat, sizeTime / 12, sizeVar);

    for varNum = 1:sizeVar
        varUsedYearly(:, :, :, varNum) = monthlyToYearly(varUsed(:, :, :, varNum));
    end

    % mask only -60-60 land.
    for varNum = 1:sizeVar
        [varUsedYearly(:, :, :, varNum), ~, ~] = maskArea(squeeze(varUsedYearly(:, :, :, varNum)), lat_f, latRange, -latRange, 'world');
    end

    % cal areaMeanLatWeight
    sizeVarUsedYearly = size(varUsedYearly);
    varUsedYearly_weightMean = zeros(sizeVarUsedYearly(3), sizeVar);

    for varNum = 1:sizeVar

        for timeNum = 1:sizeVarUsedYearly(3)
            varUsedYearly_weightMean(timeNum, varNum) = areaMeanLatWeight(varUsedYearly(:, :, timeNum, varNum), lat_f);
        end

    end

    ear5_time = time;
    clear time
    time.vec = datevec(ear5_time);
    timeYearly = unique(time.vec(:, 1));
    timeYearly = timeYearly(1:end - 1);
    % cal cc of areaMeanLatWeight
    sizeWeightMean = size(varUsedYearly_weightMean);
    cc_weightMean = cell(1, sizeWeightMean(2));
    pp_weightMean = cell(1, sizeWeightMean(2));

    for varNum = 1:sizeWeightMean(2)
        [cc0, pp0] = corrcoef(varUsedYearly_weightMean(:, 1), varUsedYearly_weightMean(:, varNum), 'Rows', 'complete');
        cc_weightMean{varNum} = roundn(cc0(1, 2), -2); %保留俩位小数
        pp_weightMean{varNum} = pp0(1, 2); % confidence interval
    end
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % cal cc of every point of map
    cc_global = zeros(nlonf, nlatf, sizeVar);
    pp_global = zeros(nlonf, nlatf, sizeVar);

    for varNum = 1:sizeVar

        for latNum = 1:nlatf

            for lonNum = 1:nlonf
                varUsedTemp = squeeze(squeeze(varUsedYearly(lonNum, latNum, :, :)));
                [cc0, pp0] = corrcoef(varUsedYearly(lonNum, latNum, :, 1), varUsedYearly(lonNum, latNum, :, varNum), 'Rows', 'complete');
                cc_global(lonNum, latNum, varNum) = roundn(cc0(1, 2), -2); %保留俩位小数
                pp_global(lonNum, latNum, varNum) = pp0(1, 2); % confidence interval
            end

        end

    end

    headLineTxt=['The correlation coefficient of dRTs and dRHeating~C~            Data: ', mlabels.dataName{1}, ', Level: ', mlabels.level, ', Era: ', tLin.time{exmNum},'~C~            global mean CC= ', num2str(cc_weightMean{2})];
    figName = [mlabels.dataName{1}, '_', tLin.time{exmNum}, '_', mlabels.area, '_', mlabels.level, '_globalDistribution'];
    figPath = [outPutPath, '/', figName];
    colorLab=mycolor(18);

end
