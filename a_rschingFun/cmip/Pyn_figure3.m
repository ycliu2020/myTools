%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-08-31 17:00:15
% LastEditTime : 2020-11-26 14:45:33
% LastEditors  : Please set LastEditors
% Description  : 同时画时间序列和相关性分布图
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/cmip/Pyn_figure3.m
%
%%---------------------------------------------------------
function [lon_f,lat_f,cc_global,headLineTxt,figurePath,colorLab] = Pyn_figure4(exmNum, mdlNum)
    % load mask map
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_cp144.mat')% load word land mask
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_ce72.mat')% load word land mask
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/correct_worldmap.mat')
    load('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/mat_file/mask14472.mat')

    latRange = 90; % Latitude range
    lon1 = [2.5 357.5]; lat1 = [-latRange + 1 latRange - 1]; % world area
    toaSfc = {'toa', 'sfc'};
    lon_k = 0:2.5:357.5; nlonk = length(lon_k); % kernel lat lon
    lat_k = 90:-2.5:-90; nlatk = length(lat_k);
    lat_f = 88.75:-2.5:-88.75; nlatf = length(lat_f); % figure lat lon
    lon_f = lon_k; nlonf = length(lon_f);

    [~, ~, level, ~, ~, ~] = cmipParameters(exmNum);
    % exmPath
    exmPath = ['/data1/liuyincheng/cmip6-process/', level.time1{exmNum}]; %/data1/liuyincheng/cmip6-process/2000-2014/
    mPath.uniOutput1 = fullfile('/home/liuyc/Research/P02.Ts_change_research/figure/proj2_cmip6Result/TimeSeries_analysis/v0.2/ts&Rheating_landMean_Radeffect', level.time1{exmNum}); %['dRTs_', lower(mlabels.level)],
    mPath.uniOutput2 = fullfile('/home/liuyc/Research/P02.Ts_change_research/figure/proj2_cmip6Result/TimeSeries_analysis/v0.2/ts&Rheating_timeCC_globalDistribution', level.time1{exmNum}); %['dRTs_', lower(mlabels.level)],
    mPath.Output1 = fullfile(mPath.uniOutput1);
    mPath.Output2 = fullfile(mPath.uniOutput2);
    auto_mkdir(mPath.Output1)
    auto_mkdir(mPath.Output2)

    % model path
    mdlName = level.model2{mdlNum};
    mdlPath = fullfile(exmPath, level.model2{mdlNum});
    eval(['cd ', mdlPath]);
    disp(' ')
    disp([level.model2{mdlNum}, ' model start!'])

    % ensemble member path
    esmName = getPath_fileName(mdlPath, '.');

    %% 暂时只看esm实验
    esm = 'r1i1p1f1';

    if sum(strcmp(esmName, esm)) == 0
        disp(['the ', esm, ' ensemble of ', mdlName, ' didnt exist']);
        figurePath='/no';
        cc_global=[];
        headLineTxt=[];
        colorLab=[];
        return
    end

    specificNum = find(strcmp(esmName, 'r1i1p1f1') == 1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % ensemble member
    for esmNum = specificNum:specificNum%1:length(esmName)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% load and read
        esmPath = fullfile(mdlPath, esmName{esmNum, 1});
        % data path
        varsPath = fullfile(esmPath, level.process3{1}); %/data1/liuyincheng/cmip6-process/2000-2014/MRI-ESM2-0/rawdata_regrid
        dvarsPath = fullfile(esmPath, level.process3{2}); %/data1/liuyincheng/cmip6-process/2000-2014/MRI-ESM2-0/anomaly
        dvarsTrendPath = fullfile(esmPath, level.process3{3}); %/data1/liuyincheng/cmip6-process/2000-2014/MRI-ESM2-0/anomaly_trend
        kernelPath = fullfile(esmPath, level.process3{5}); %/data1/liuyincheng/cmip6-process/2000-2014/MRI-ESM2-0/kernelsCal
        dradEffectPath = fullfile(esmPath, level.process3{6}); %/data1/liuyincheng/cmip6-process/2000-2014/MRI-ESM2-0/radEffect/
        dnonLocalCldPath = fullfile(esmPath, level.process3{8}); %/data1/liuyincheng/cmip6-process/2000-2014/MRI-ESM2-0/non_localCld/
        load([dradEffectPath, 'global_vars.mat'])% lat_f lon_f time plev_k readme
        ntime = length(time.date);

        % cal surface temperature
        load([varsPath, 'ts.mat'])% ts
        load([dvarsPath, 'dts.mat'])%dts
        dts = autoRegrid3(lon_k, lat_k, time.date, dts, lon_f, lat_f, time.date);
        ts = autoRegrid3(lon_k, lat_k, time.date, ts, lon_f, lat_f, time.date);

        % cal rhs(RHeating)
        load([dvarsPath, 'drlds.mat'])% surface_downwelling_longwave_flux_in_air
        load([dvarsPath, 'drsds.mat'])% surface_downwelling_shortwave_flux_in_air
        load([dvarsPath, 'drsus.mat'])% surface_upwelling_shortwave_flux_in_air
        dR_swnet = drsds - drsus; % sfc net shortwave flux
        drhs = drlds + dR_swnet; % equilibrium equation's RHS, nearly equal to sfc upward rad
        drhs = autoRegrid3(lon_k, lat_k, time.date, drhs, lon_f, lat_f, time.date);

        % cloud radRffect
        load([dradEffectPath, 'dR_cloud_toa.mat'])
        load([dradEffectPath, 'dR_cloud_sfc.mat'])

        % TotalEffect
        load([dradEffectPath, 'dradEfect_sfc_cld.mat'])% 'totalEffect', 'wvlwEffect', 'wvswEffect', 'tsEffect', 'albEffect', 'husEffect', 'taEffect', 'tasEffect2', 'taOnlyEffect2', 'totalEffect', 'mainEffect'
        load([dradEffectPath, 'real_dradEfect.mat'])% 'dR_allsky', 'l_rad', 's_rad', 'dR_clr', 'readme_realradEfect'
        load([dradEffectPath, 'dR_residual_cld_sfc.mat'])% dR_residual_cld_sfc
        load([dradEffectPath, 'dR_residual_cld_toa.mat'])% dR_residual_cld_toa
        dR_netSfc = squeeze(dR_allsky(:, :, :, 1));
        dR_netTOA = squeeze(dR_allsky(:, :, :, 2));
        varUsed = zeros(nlonf, nlatf, ntime, 2);
        varUsed(:, :, :, 1) = tsEffect;
        varUsed(:, :, :, 2) = drhs;
        varNames = {'dR_{Ts}', 'dRHeating', 'ta RadEfect', 'ts RadEfect', 'q RadEfect', 'alb RadEfect'};
        yLabel = {'W/m2', 'W/m2', 'W/m2', 'W/m2', 'W/m2', 'W/m2'};

        % varUsed(:, :, :, 1) = dR_netSfc;
        % varUsed(:, :, :, 2) = dR_cloud_sfc;
        % varUsed(:, :, :, 3) = taEffect;
        % varUsed(:, :, :, 4) = tsEffect;
        % varUsed(:, :, :, 5) = wvlwEffect+wvswEffect;
        % varUsed(:, :, :, 6) = albEffect;
        % varNames = {'Total radiation', 'cloud RadEfect', 'ta RadEfect', 'ts RadEfect', 'q RadEfect', 'alb RadEfect'};
        % transfor to yearly Data
        sizeVarUsed = size(varUsed);
        sizeLon = sizeVarUsed(1); sizeLat = sizeVarUsed(2); sizeTime = sizeVarUsed(3); sizeVar = sizeVarUsed(4);
        varUsedYearly = zeros(sizeLon, sizeLat, sizeTime / 12, sizeVar);

        for varNum = 1:sizeVar
            varUsedYearly(:, :, :, varNum) = monthlyToYearly(varUsed(:, :, :, varNum));
        end

        % mask land.
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

        time.vec = datevec(time.date);
        timeYearly = unique(time.vec(:, 1));
        % cal cc of areaMeanLatWeight
        sizeWeightMean = size(varUsedYearly_weightMean);
        cc_weightMean = cell(1, sizeWeightMean(2));
        pp_weightMean = cell(1, sizeWeightMean(2));

        for varNum = 1:sizeWeightMean(2)
            [cc0, pp0] = corrcoef(varUsedYearly_weightMean(:, 1), varUsedYearly_weightMean(:, varNum), 'Rows', 'complete');
            cc_weightMean{varNum} = roundn(cc0(1, 2), -2); %保留俩位小数
            pp_weightMean{varNum} = pp0(1, 2); % confidence interval
        end

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    headLineTxt = ['The correlation coefficient of dRTs and dRHeating, Level:', toaSfc{2}, '~C~            Era: ', level.time1{exmNum}(1:end - 1), ', Model:', level.model2{mdlNum}, '~C~            Ensemble: ', esmName{esmNum},', global mean CC= ', num2str(cc_weightMean{2})];
    figName = [level.time1{exmNum}(1:end - 1), '_', level.model2{mdlNum}, '_', esmName{esmNum}];
    figurePath = [mPath.Output2, '/', figName];
    colorLab=mycolor(18);

end
