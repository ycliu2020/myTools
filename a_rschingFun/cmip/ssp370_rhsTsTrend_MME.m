%%---------------------------------------------------------
% Author       : LYC
% Date         : 2021-05-11 14:34:48
% LastEditors  : Please set LastEditors
% Description  :
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/cmip/ssp370_rhsTsTrend_MME.m
%
%%---------------------------------------------------------
function [lon_f, lat_f, trendyr, figTitle, figPath, colorLab] = ssp370_rhsTsTrend_MME(MMEType, exmNum, plotType)
    run '/home/liuyc/lib/tools/matlab/myTools/autoScript/preLoadVar.m'
    MMENum = str2num(MMEType(end));
    [mlabels, areaNum] = cmipPlotParameters('sfc', 'land', 'radEffect'); % plot parameters
    [readme, Experiment, level, tLin, mPlev, vars] = cmipParameters(exmNum);
    % MMEPath
    MMEPath = fullfile(level.path_MME, MMEType, level.time1{exmNum}); %/data1/liuyincheng/CMIP6-process/2000-2014/
    figDataPath = fullfile(MMEPath, 'FigData/');
    dradEffectTrendPath = fullfile(MMEPath, level.process3{7}); % /radEffect_trend
    dvarsTrendPath = fullfile(MMEPath, level.process3{3}); % /anomaly_trend

    %% load and read
    load([dradEffectTrendPath, 'global_vars.mat']) % 'lon_f', 'lat_f', 'timeEssmble', 'time', 'plev_k', 'readme', 'timeseries', 'MME_Models'
    ntime = length(time.date);
    load([dradEffectTrendPath, 'trend_dradEffect_sfc_cld.mat']) % 'trendyr_dRsfc_CRF', 'trendyr_dRsfc_ta', 'trendyr_dRsfc_taOnly', 'trendyr_dRsfc_tas1', 'trendyr_dRsfc_tas', 'trendyr_dRsfc_tas2', 'trendyr_dRatm_tsAtom', 'trendyr_dRsfc_nonTs', 'trendyr_dRsfc_residual', 'trendyr_dRsfc_cloud', 'trendyr_dRsfc_q', 'trendyr_dRsfc_alb', 'trendyr_dRsfc_ts'

    load([dvarsTrendPath, 'trend_drhs.mat']) % trendyr_drhs
    load([dvarsTrendPath, 'trend_dhFlux.mat']) % trendyr_dhFlux

    trendyr_drhsKern = trendyr_dRsfc_ta + trendyr_dRsfc_q + trendyr_dRsfc_alb + trendyr_dRsfc_cloud;

    % use one var to plot
    trendyr = zeros(nlonf, nlatf, 4);
    trendyr(:, :, 1) = -trendyr_dRsfc_ts;
    trendyr(:, :, 2) = trendyr_drhs;
    trendyr(:, :, 3) = trendyr_drhsKern;
    trendyr(:, :, 4) = trendyr(:, :, 2) - trendyr(:, :, 1); % res
    trendyr(:, :, 5) = trendyr_dhFlux; % -rh-sh
    trendyr(:, :, 6) = trendyr(:, :, 4)+trendyr(:, :, 5); % -rh-sh

    trendyr = trendyr * 365 * 10;

    % mask and cal the cc
    [trendyr, yr_cc, yr_pp] = maskArea(trendyr, lat_f, latRange, -latRange, areaNum);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % plot Part
    f_row = 2; f_col = 3; % 设置画图的行列

    figTitle.subTitle = cell(1, f_row*f_col);
    figTitle.subTitle = {['-K~B~Ts~N~', '~F20~G~F19~[', '~F21~T~B~s~N~'], ['dR~B~heating~N~', ', r=', num2str(yr_cc{2})], ['dR~B~heating, Kern~N~', ', r=', num2str(yr_cc{3})], ['(b)-(a)'],['LH+SH'],['(d)+(e)']};   
    figTitle.headLineTxt = ['Level:', mlabels.level, ', Data: ', level.time1{exmNum}(6:end - 11), ', Trend(year mean)~C~           MME Type:', MMEType, ', Unit: W/m2/10a'];
    figTitle.seqNum=cell(1, f_row*f_col);
    for rowNum = 1:f_row*f_col
        figTitle.seqNum{rowNum}=['(', char(96 + rowNum), ')'];
    end
    % color bar
    colorLab1 = mycolor('freshStyle_16');
    if plotType==4
        colorLab = colorLab1(end - 9:end, :);
        colorLab(1,:) = colorLab(2,:);
        colorLab(2,:) = [1,1,1];
        colorLab(4:end+1,:)= colorLab(3:end,:);
        colorLab(3,:) = [1,1,1];
    elseif plotType==6
        colorLab = colorLab1(end - 10:end, :);
        colorLab(1,:) = colorLab1(end - 11,:);
        % colorLab(2,:) = [1,1,1];
        colorLab(6:end+2,:)= colorLab(4:end,:);
        colorLab(4,:) = [1,1,1];
        colorLab(5,:) = [1,1,1];
    end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% save Part
    mPath.outPut = fullfile('/home/liuyc/Research/P02.Ts_change_research/figure/figOfSketch/SSP370_longTimeTrend/RheatingVsLW'); %['dRTs_', lower(mlabels.level)],
    auto_mkdir(mPath.outPut)
    figName = [MMEType, '_Glb_rhsVsLW_', level.time1{exmNum}(6:end - 11),'_',num2str(plotType),'Plot'];
    figPath = [mPath.outPut, '/', figName];



end


