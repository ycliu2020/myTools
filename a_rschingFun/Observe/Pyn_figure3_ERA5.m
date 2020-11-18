%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-11-17 09:38:25
% LastEditTime : 2020-11-17 14:22:30
% LastEditors  : LYC
% Description  : 
% FilePath     : /code/p1_processObserveData/ERA5/plot/Pyn_figure3_ERA5.m
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
function [lon_f, lat_f, trendyr,figTitle, figPath, colorLab] = Pyn_figure3_ERA5(exmNum)

    % load mask map
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_cp144.mat')% load word land mask
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_ce72.mat')% load word land mask
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/correct_worldmap.mat')
    load('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/mat_file/mask14472.mat')
    [mlabels, areaNum] = obsPlotParameters('sfc', 'land', 'ERA5-radEffect-tsRad');
    [readme, level, tLin, vars] = obsParameters('ERA5');   

    %% global set
    % Latitude range
    latRange = 90;
    lon1 = [2.5 357.5]; lat1 = [-latRange + 1 latRange - 1]; % world area
    lon_k = 0:2.5:357.5; nlonk = length(lon_k); % kernel lat lon
    lat_k = 90:-2.5:-90; nlatk = length(lat_k);
    lat_f = 88.75:-2.5:-88.75; nlatf = length(lat_f); % figure lat lon
    lon_f = lon_k; nlonf = length(lon_f);
    varsPath = fullfile('/data1/liuyincheng/Observe-process', tLin.time{exmNum}, 'ERA5', level.standVarPath{1}); %rawdata
    dvarsPath = fullfile('/data1/liuyincheng/Observe-process', tLin.time{exmNum}, 'ERA5', level.standVarPath{2}); %anomaly
    dvarsTrendPath = fullfile('/data1/liuyincheng/Observe-process', tLin.time{exmNum}, 'ERA5', level.standVarPath{3}); %anomaly_trend
    kernelCalPath = fullfile('/data1/liuyincheng/Observe-process', tLin.time{exmNum}, 'ERA5', level.standVarPath{4}); % kernelCal
    radEfectPath = fullfile('/data1/liuyincheng/Observe-process', tLin.time{exmNum}, 'ERA5', level.standVarPath{5}); %radEffect
    dradTrendPath = fullfile('/data1/liuyincheng/Observe-process', tLin.time{exmNum}, 'ERA5', level.standVarPath{6}); %/data1/liuyincheng/cmip6-proces/aimp_2000-2014/MRI-ESM2-0/ensemble/radEffect_trend/
    outPutPath = fullfile('/home/liuyc/Research/P02.Ts_change_research/figure/proj1_Observe/Radiative_effect/v0.2/',  ['ERA5_',tLin.time{exmNum}]);
    auto_mkdir(outPutPath)

    load([dvarsTrendPath, 'global_vars.mat'])%% 'lon_f', 'lat_f', 'lon_k', 'lat_k', 'plev_k', 'time'
    load([dradTrendPath, 'trend_dradEfect_toa_cld.mat'])% 10 vars:'trendyr_dRtoa_ta','trendyr_dRtoa_taOnly2', 'trendyr_dRtoa_tas2., 'trendyr_dRtoa_tsAtom', 'trendyr_dRtoa_mainEffect', 'trendyr_dRtoa_residual', 'trendyr_dRtoa_cloud', 'trendyr_dRtoa_q', 'trendyr_dRtoa_alb', 'trendyr_dRtoa_ts'
    load([dradTrendPath, 'trend_dradEfect_sfc_cld.mat'])% 10 vars:'trendyr_dRsfc_ta','trendyr_dRsfc_taOnly2', 'trendyr_dRsfc_tas2., 'trendyr_dRsfc_tsAtom', 'trendyr_dRsfc_mainEffect', 'trendyr_dRsfc_residual', 'trendyr_dRsfc_cloud', 'trendyr_dRsfc_q', 'trendyr_dRsfc_alb', 'trendyr_dRsfc_ts'
    load([dvarsTrendPath, 'trend_dnetTOA.mat'])% trendyr_dnetTOA
    load([dvarsTrendPath, 'trend_drhs.mat'])% trendyr_drhs
    load([dvarsTrendPath, 'trend_dhFlux.mat'])% trendyr_dhFlux
    load([dvarsTrendPath, 'trend_drhsPlus.mat'])% trendyr_dhFlux
    load([dvarsTrendPath, 'trend_dts.mat'])% trendyr_dts
    nlonf = length(lon_f);
    nlatf = length(lat_f);
    % use one var to plot
    trendyr = zeros(nlonf, nlatf, 9);

    for varNum = 1:9
        eval(['trendyr(:,:,varNum)=', mlabels.vars{varNum}, ';'])
    end

    trendyr = trendyr * 365 * 10;
    trendyr(:, :, 1) = trendyr(:, :, 1);
    % mask and cal the cc
    [trendyr, yr_cc, ~] = maskArea(trendyr, lat_f, latRange, -latRange, areaNum);


    f_row = 1; f_col = 2; % 设置画图的行列
    figTitle.subTitle = cell(1,2);
    for varNum = 1:f_row * f_col
        figTitle.subTitle{varNum}=[mlabels.component{varNum}, mlabels.unite{varNum},'~C~            spatial cc = ', num2str(yr_cc{varNum})];
    end
    figTitle.headLineTxt = ['Level:', mlabels.level, ', Era: ', tLin.time{exmNum}, '~C~            Data:', mlabels.dataName{1}, ', Trend(year mean)'];
    
    figName = [mlabels.dataName{1}, '_', tLin.time{exmNum}, '_', mlabels.figType{1}, '_', mlabels.area, '_', mlabels.level,'_fig3'];
    figPath = [outPutPath, '/', figName];
    colorLab=mycolor(18);

end
