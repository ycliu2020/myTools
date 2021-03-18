%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-11-17 09:38:25
% LastEditTime : 2021-03-11 22:35:12
% LastEditors  : Please set LastEditors
% Description  :
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/cmip/Pyn_figure9.m
%
%%---------------------------------------------------------
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% mothly data
% plot the Ts trend and rhs,Ts, Ta, wv, albedo trend(TOA)
% note: the trendyr already be masked and caled cc
%
% experiment information:
% time:2000.01-2014.12(interval:15*12);1980.01-2014.12(interval:35*12); 2015.01-2099.12(interval:85*12)
% initial time in hist(1740 total): 1,561 of 1740(2000.03);1,321 of 1740(1980.01)
% initial time in futrue(1032 total): 1 of 1032(2015.01);
%
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function [lon_f, lat_f, trendyr, figTitle, figPath, colorLab] = Pyn_figure9(exmNum, mdlNum)

    % load mask map
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_cp144.mat')% load word land mask
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_ce72.mat')% load word land mask
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/correct_worldmap.mat')
    load('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/mat_file/mask14472.mat')
    [mlabels, areaNum] = cmipPlotParameters('sfc', 'land', 'radEffect'); % plot parameters
    %% global set
    % Latitude range
    latRange = 90;
    lon1 = [2.5 357.5]; lat1 = [-latRange + 1 latRange - 1]; % world area
    lon_k = 0:2.5:357.5; nlonk = length(lon_k); % kernel lat lon
    lat_k = 90:-2.5:-90; nlatk = length(lat_k);
    lat_f = 88.75:-2.5:-88.75; nlatf = length(lat_f); % figure lat lon
    lon_f = lon_k; nlonf = length(lon_f);

    [~, ~, level, ~, ~, ~] = cmipParameters(exmNum);
    % mPath.input:E:/data/CMIP6-process/2000-2014/
    mPath.input = fullfile('/data1/liuyincheng/CMIP6-process/', level.time1{exmNum});
    % mPath.output:a_research/P02.Ts_change_research/figure/04.cmip6Result/2000-2014/
    mPath.uniOutput = fullfile('/home/liuyc/Research/P02.Ts_change_research/figure/proj3_PaperFig/v0.0/Fig9_CMIP6_ssp370_Trend/', level.time1{exmNum});
    mPath.Output = fullfile(mPath.uniOutput);
    auto_mkdir(mPath.Output)

    % model path
    mdlPath = fullfile(mPath.input, level.model2{mdlNum});
    eval(['cd ', mdlPath]);
    disp(' ')
    disp([level.model2{mdlNum}, ' model start!'])

    esm = 'r1i1p1f1';
    esmPath = fullfile(mdlPath, esm);

    if ~exist(esmPath, 'dir')
        disp(['the ', esm, ' ensemble of ', level.model2{mdlNum}, ' didnt exist']);
        figPath = '/no';
        trendyr = [];
        figTitle = [];
        colorLab = [];
        return
    end
    
    % load data

    varsPath = fullfile(esmPath, level.process3{1}); %/data1/liuyincheng/CMIP6-process/2000-2014/MRI-ESM2-0/rawdata
    dvarsPath = fullfile(esmPath, level.process3{2}); %/data1/liuyincheng/CMIP6-process/2000-2014/MRI-ESM2-0/anomaly
    dvarsTrendPath = fullfile(esmPath, level.process3{3}); %/data1/liuyincheng/CMIP6-process/2000-2014/MRI-ESM2-0/anomaly_trend
    kernelPath = fullfile(esmPath, level.process3{5}); %/data1/liuyincheng/CMIP6-process/2000-2014/MRI-ESM2-0/kernelsCal
    dradEffectPath = fullfile(esmPath, level.process3{6}); %/data1/liuyincheng/CMIP6-process/2000-2014/MRI-ESM2-0/radEffect/
    dradTrendPath = fullfile(esmPath, level.process3{7}); %/data1/liuyincheng/CMIP6-process/amip_1980-2014/CESM2/radEffect_trend
    dnonLocalCldPath = fullfile(esmPath, level.process3{8}); %/data1/liuyincheng/CMIP6-process/2000-2014/MRI-ESM2-0/non_localCld/
    vsTsEffectTrendPath = fullfile(esmPath, level.process3{10}); %/data1/liuyincheng/CMIP6-process/2000-2014/MRI-ESM2-0/vsTsEffect_trend/

    load([dradTrendPath, 'global_vars.mat'])% lat lon time plevf readme
    load([dradTrendPath, 'trend_dradEffect_toa_cld.mat'])% 10 vars:'trendyr_dRtoa_ta','trendyr_dRtoa_taOnly2', 'trendyr_dRtoa_tas2., 'trendyr_dRtoa_tsAtom', 'trendyr_dRtoa_mainEffect', 'trendyr_dRtoa_residual', 'trendyr_dRtoa_cloud', 'trendyr_dRtoa_q', 'trendyr_dRtoa_alb', 'trendyr_dRtoa_ts'
    load([dradTrendPath, 'trend_dradEffect_sfc_cld.mat'])% 10 vars:'trendyr_dRsfc_ta','trendyr_dRsfc_taOnly2', 'trendyr_dRsfc_tas2., 'trendyr_dRsfc_tsAtom', 'trendyr_dRsfc_mainEffect', 'trendyr_dRsfc_residual', 'trendyr_dRsfc_cloud', 'trendyr_dRsfc_q', 'trendyr_dRsfc_alb', 'trendyr_dRsfc_ts'
    load([dvarsTrendPath, 'trend_dnetTOA.mat'])% trendyr_dnetTOA
    load([dvarsTrendPath, 'trend_drhs.mat'])% trendyr_drhs
    load([dvarsTrendPath, 'trend_dhFlux.mat'])% trendyr_dhFlux
    load([dvarsTrendPath, 'trend_drhsPlus.mat'])% trendyr_dhFlux
    load([dvarsTrendPath, 'trend_dts.mat'])% trendyr_dts
    load([vsTsEffectTrendPath, ['trend_dTs_x_', lower(mlabels.level), '.mat']])% trendm_dTs_alb, trendm_dTs_cld, trendm_dTs_hus, trendm_dTs_ta, trends_dTs_alb, trends_dTs_cld, trends_dTs_hus, trends_dTs_ta, trendyr_dTs_alb, trendyr_dTs_cld, trendyr_dTs_hus, trendyr_dTs_ta

    nlonf = length(lon_f); nlatf = length(lat_f);

    % trendyr_dRatm_tsAtom=-trendyr_dRatm_tsAtom; % dim downward rad as positive
    % use one var to plot
    trendyr = zeros(nlonf, nlatf, 6);
    trendyr(:, :, 1) = trendyr_dts;
    trendyr(:, :, 2) = trendyr_dTs_cld;
    trendyr(:, :, 3) = trendyr_dTs_ta;
    trendyr(:, :, 4) = trendyr_dTs_hus;
    trendyr(:, :, 5) = trendyr_dTs_alb;
    trendyr(:, :, 6) = trendyr_dTs_residual;

    mlabels.component = {'Total surface temperature change', 'Cloud contribution', 'Air temperature contribution', 'q contribution', 'Albedo contribution', 'Residual contribution'};
    trendyr = trendyr * 365 * 10;
    % mask and cal the cc
    [trendyr, yr_cc, yr_pp] = maskArea(trendyr, lat_f, latRange, -latRange, areaNum);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %plot
    f_row = 3; f_col = 2; % 设置画图的行列
    figTitle.subTitle = cell(1, 6);

    for varNum = 1:f_row * f_col
        figTitle.subTitle{varNum} = mlabels.component{varNum};
    end

    figTitle.headLineTxt = ['Level:', mlabels.level, ', Era: ', level.time1{exmNum}(5:end - 1), ', Trend(year mean)~C~            Model:', level.model2{mdlNum}, ', Ensemble: ', esm, ', Unit: K/10a'];

    figName = [level.time1{exmNum}(5:end - 1), '_', level.model2{mdlNum}, '_', mlabels.fileN1, '_', esm];
    figPath = [mPath.Output, '/', figName];
    colorLab1 = mycolor('freshStyle_16');
    colorLab =colorLab1(end-9:end,:);
    colorLab(1)=colorLab1(5);
end
