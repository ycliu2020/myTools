%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-08-31 17:00:15
% LastEditTime : 2021-05-12 22:34:39
% LastEditors  : Please set LastEditors
% Description  : 同时画时间序列和相关性分布图
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/Observe/Pyn_figure4_ERA5.m
%
%%---------------------------------------------------------
function [lon_f, lat_f, cc_global, headLineTxt, figPath, colorLab] = Pyn_figure4_ERA5(exmNum)
    % load mask map
    run '/home/liuyc/lib/tools/matlab/myTools/autoScript/preLoadVar.m'

    [mlabels, ~] = obsPlotParameters('sfc', 'land', 'ERA5-radEffect-ts');
    [readme, level, tLin, vars] = obsParameters('ERA5');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %read data
    ERAPath=fullfile('/data2/liuyincheng/Observe-process', tLin.time{exmNum},'ERA5')
    varsPath = fullfile(ERAPath, level.standVarPath{1}); %rawdata
    dvarsPath = fullfile(ERAPath, level.standVarPath{2}); %anomaly
    dvarsTrendPath = fullfile(ERAPath, level.standVarPath{3}); %anomaly_trend
    kernelCalPath = fullfile(ERAPath, level.standVarPath{4}); % kernelCal
    radEffectPath = fullfile(ERAPath, level.standVarPath{5}); %radEffect
    dradTrendPath = fullfile(ERAPath, level.standVarPath{6}); %/data1/liuyincheng/cmip6-proces/aimp_2000-2014/MRI-ESM2-0/ensemble/radEffect_trend/
    outPutPath = fullfile('/home/liuyc/Research/P02.Ts_change_research/figure/proj3_PaperFig/v0.3/Fig4_ts&Rheating_timeCC_globalDistribution');
    auto_mkdir(outPutPath)
    load([dvarsTrendPath, 'global_vars.mat']) % % 'lon_f', 'lat_f', 'lon_k', 'lat_k', 'plev_k', 'time'
    load([radEffectPath, 'dradEffect_sfc_cld.mat']) % load albEffect, husEffect, mainEffect, taEffect, taOnlyEffect, taOnlyEffect2, tasEffect, tasEffect2, totalEffect, tsEffect, wvlwEffect, wvswEffect
    load([dvarsPath, 'drhs.mat']) % load drhs
    ntime = length(time);
    % regrid
    drhs = autoRegrid3(lon_k, lat_k, time, drhs, lon_f, lat_f, time);

    varUsed = zeros(nlonf, nlatf, ntime, 2);
    varUsed(:, :, :, 1) = -tsEffect;
    varUsed(:, :, :, 2) = drhs;
    varNames = {'dR_{Ts}', 'dRHeating', 'ta RadEffect', 'ts RadEffect', 'q RadEffect', 'alb RadEffect'};
    yLabel = {'W/m2', 'W/m2', 'W/m2', 'W/m2', 'W/m2', 'W/m2'};

    sizeVarUsed = size(varUsed);
    sizeLon = sizeVarUsed(1); sizeLat = sizeVarUsed(2); sizeTime = sizeVarUsed(3); sizeVar = sizeVarUsed(4);
    varUsedYearly = zeros(sizeLon, sizeLat, sizeTime / 12, sizeVar);

    for varNum = 1:sizeVar
        varUsedYearly(:, :, :, varNum) = monthlyToYearly(varUsed(:, :, :, varNum));
    end

    % mask
    for varNum = 1:sizeVar
        [varUsedYearly(:, :, :, varNum), ~, ~] = maskArea(squeeze(varUsedYearly(:, :, :, varNum)), lat_f, latRange, -latRange, 'world');
    end

    % detrend
    for varNum = 1:sizeVar

        for latNum = 1:nlatf

            for lonNum = 1:nlonf
                varUsedYearly(lonNum, latNum, :, varNum) = detrend(squeeze(squeeze(varUsedYearly(lonNum, latNum, :, varNum))));
            end

        end

    end

    % cal areaMeanLatWeight
    sizeVarUsedYearly = size(varUsedYearly);
    varUsedYearly_weightMean = zeros(sizeVarUsedYearly(3), sizeVar);

    for varNum = 1:sizeVar

        for timeNum = 1:sizeVarUsedYearly(3)
            varUsedYearly_weightMean(timeNum, varNum) = areaMeanLatWeight(varUsedYearly(:, :, timeNum, varNum), lat_f);
        end

    end

    % % cut to 2000.03-2014-02
    % timeStr=string(datestr(datenum(time),'yyyy-mm-dd'));
    % cutEnd=find(timeStr=='2014-02-01');
    % time=time(1:cutEnd);
    % ntime = length(time);
    % varUsedYearly_weightMean=varUsedYearly_weightMean(1:14,:);

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

    headLineTxt = ['The correlation coefficient of LW_up and dRHeating~C~            Data: ', mlabels.dataName{1}, ', Level: ', mlabels.level, ', Era: ', tLin.time{exmNum}, '~C~            global mean CC= ', num2str(cc_weightMean{2})];
    figName = ['Fig4_', mlabels.dataName{1}, '_', tLin.time{exmNum}, '_', mlabels.area, '_', mlabels.level, '_globalDistribution'];
    figPath = [outPutPath, '/', figName];
    colorLab = mycolor(18);

end
