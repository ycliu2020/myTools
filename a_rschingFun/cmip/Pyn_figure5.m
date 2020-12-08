%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-11-17 09:38:25
% LastEditTime : 2020-11-26 15:06:40
% LastEditors  : Please set LastEditors
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/cmip/Pyn_figure5.m
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
function [lon_f, lat_f, trendyr,figTitle, figPath, colorLab] = Pyn_figure5(exmNum, mdlNum)

    % load mask map
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_cp144.mat')% load word land mask
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_ce72.mat')% load word land mask
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/correct_worldmap.mat')
    load('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/mat_file/mask14472.mat')
    [mlabels, areaNum] = cmipPlotParameters('sfc', 'land', 'radEffect'); % plot parameters
    esm = 'r1i1p1f1';
    %% global set
    % Latitude range
    latRange = 90;
    lon1 = [2.5 357.5]; lat1 = [-latRange + 1 latRange - 1]; % world area
    lon_k = 0:2.5:357.5; nlonk = length(lon_k); % kernel lat lon
    lat_k = 90:-2.5:-90; nlatk = length(lat_k);
    lat_f = 88.75:-2.5:-88.75; nlatf = length(lat_f); % figure lat lon
    lon_f = lon_k; nlonf = length(lon_f);

    [~, ~, level, ~, ~, ~] = cmipParameters(exmNum);
    % mPath.input:E:/data/cmip6-process/2000-2014/
    mPath.input = fullfile('/data1/liuyincheng/cmip6-process/', level.time1{exmNum});
    % mPath.output:a_research/P02.Ts_change_research/figure/04.cmip6Result/2000-2014/


    % model path
    mdlPath = fullfile(mPath.input, level.model2{mdlNum});
    eval(['cd ', mdlPath]);
    disp(' ')
    disp([level.model2{mdlNum}, ' model start!'])

    % load data
    dradTrendPath = fullfile(mdlPath, esm, level.process3{7}); %/data1/liuyincheng/cmip6-process/amip_1980-2014/CESM2/Effect_trend
    danomTrendPath = fullfile(mdlPath, esm, level.process3{3}); %/data1/liuyincheng/cmip6-process/amip_1980-2014/CESM2/anomaly_trend

    if ~exist(dradTrendPath, 'dir')
        disp(['the ', esm, ' ensemble of ', level.model2{mdlNum}, ' didnt exist']);
        figPath = '/no';
        trendyr = [];
        figTitle = [];
        colorLab = [];
        return
    end

    load([dradTrendPath, 'global_vars.mat'])% lat_f lon_f time plevf readme
    load([dradTrendPath, 'trend_dradEfect_toa_cld.mat'])% 10 vars:'trendyr_dRtoa_ta','trendyr_dRtoa_taOnly2', 'trendyr_dRtoa_tas2., 'trendyr_dRtoa_tsAtom', 'trendyr_dRtoa_mainEffect', 'trendyr_dRtoa_residual', 'trendyr_dRtoa_cloud', 'trendyr_dRtoa_q', 'trendyr_dRtoa_alb', 'trendyr_dRtoa_ts'
    load([dradTrendPath, 'trend_dradEfect_sfc_cld.mat'])% 10 vars:'trendyr_dRsfc_ta','trendyr_dRsfc_taOnly2', 'trendyr_dRsfc_tas2., 'trendyr_dRsfc_tsAtom', 'trendyr_dRsfc_mainEffect', 'trendyr_dRsfc_residual', 'trendyr_dRsfc_cloud', 'trendyr_dRsfc_q', 'trendyr_dRsfc_alb', 'trendyr_dRsfc_ts'
    load([danomTrendPath, 'trend_dnetTOA.mat'])% trendyr_dnetTOA
    load([danomTrendPath, 'trend_drhs.mat'])% trendyr_drhs
    load([danomTrendPath, 'trend_dhFlux.mat'])% trendyr_dhFlux
    load([danomTrendPath, 'trend_drhsPlus.mat'])% trendyr_dhFlux
    load([danomTrendPath, 'trend_dts.mat'])% trendyr_dts
    nlonf = length(lon_f); nlatf = length(lat_f);
    trendyr_dRatm_ta = trendyr_dRtoa_ta - trendyr_dRsfc_ta;
    trendyr_dRatm_tas2 = trendyr_dRtoa_tas2 - trendyr_dRsfc_tas2;
    trendyr_dRatm_taOnly2 = trendyr_dRtoa_taOnly2 - trendyr_dRsfc_taOnly2;
    trendyr_dRatm_cloud = trendyr_dRtoa_cloud - trendyr_dRsfc_cloud;
    trendyr_dRatm_q = trendyr_dRtoa_q - trendyr_dRsfc_q;
    trendyr_dRatm_alb = trendyr_dRtoa_alb - trendyr_dRsfc_alb;
    trendyr_dRatm_mainEffect = trendyr_dRtoa_mainEffect - trendyr_dRsfc_mainEffect;
    trendyr_dRatm_residual = trendyr_dRtoa_residual - trendyr_dRsfc_residual;

    % trendyr_dRatm_tsAtom=-trendyr_dRatm_tsAtom; % dim downward rad as positive
    % use one var to plot
    trendyr = zeros(nlonf, nlatf, 12);

    for varNum = 1:12
        eval(['trendyr(:,:,varNum)=', mlabels.vars{varNum}, ';'])
    end

    trendyr = trendyr * 365 * 10;
    trendyr(:, :, 1) = trendyr(:, :, 1);
    trendyr(:, :, 10) = trendyr(:, :, 10);
    % mask and cal the cc
    [trendyr, yr_cc, ~] = maskArea(trendyr, lat_f, latRange, -latRange, areaNum);

    f_row = 1; f_col = 3; % 设置画图的行列
    figTitle.subTitle = cell(1,3);
    for varNum = 1:f_row * f_col
        figTitle.subTitle{varNum}=[mlabels.component{varNum}, mlabels.unite{varNum},'~C~            spatial cc = ', num2str(yr_cc{varNum})];
        if varNum==3
            figTitle.subTitle{varNum}=[mlabels.component{8}, mlabels.unite{8},'~C~            spatial cc = ', num2str(yr_cc{8})];

        end
    end
    figTitle.headLineTxt = ['Level:', mlabels.level, ', Era: ', level.time1{exmNum}(1:end - 1), ', Trend(year mean)~C~            Model:', level.model2{mdlNum}, ', Ensemble: ', esm];
    
    mPath.uniOutput = fullfile('/home/liuyc/Research/P02.Ts_change_research/figure/proj3_PaperFig/v0.0/Fig5_CMIP6_radEffectTrend');
    mPath.Output = fullfile(mPath.uniOutput);
    auto_mkdir(mPath.Output)
    figName = ['Fig5_', level.model2{mdlNum}, '_', esm, '_', level.time1{exmNum}(1:end - 1), '_', mlabels.fileN1];
    figPath = [mPath.Output, '/', figName];
    colorLab=mycolor(18);


    
end
