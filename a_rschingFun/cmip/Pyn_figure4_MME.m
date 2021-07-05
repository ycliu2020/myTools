%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-08-31 17:00:15
% LastEditTime : 2021-06-24 05:26:03
% LastEditors  : Please set LastEditors
% Description  : 同时画时间序列和相关性分布图
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/cmip/Pyn_figure4_MME.m
%
%%---------------------------------------------------------
function [lon_f, lat_f, cc_global, headLineTxt, figurePath, colorLab] = Pyn_figure4(exmNum, MMECode)
    % load mask map
    run '/home/liuyc/lib/tools/matlab/myTools/autoScript/preLoadVar.m'
    
    [~, ~, level, ~, ~, ~] = cmipParameters(exmNum);
    % exmPath
    exmPath = ['/data1/liuyincheng/CMIP6-process/', level.time1{exmNum}]; %/data1/liuyincheng/CMIP6-process/2000-2014/

    outputPath = fullfile('/home/liuyc/Research/P02.Ts_change_research/figure/figOfPaper/v0.3/Fig4_ts&Rheating_timeCC_globalDistribution', level.time1{exmNum}); %['dRTs_', lower(mlabels.level)];
    auto_mkdir(outputPath)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% load and read
    % MMEPath
    MMEPath = fullfile(level.path_MME, MMECode, level.time1{exmNum}); %/data1/liuyincheng/CMIP6-process/2000-2014/
    % data path
    dvarsPath = fullfile(MMEPath, level.process3{2}); %/data1/liuyincheng/CMIP6-process/2000-2014/MRI-ESM2-0/anomaly
    dradEffectPath = fullfile(MMEPath, level.process3{6}); %/data1/liuyincheng/CMIP6-process/2000-2014/MRI-ESM2-0/radEffect/
    figDataPath = fullfile(MMEPath, 'FigData/');

    load([dradEffectPath, 'global_vars.mat']) % lat_f lon_f time plev_k readme
    ntime = length(time.date);

    % load Data
    load([figDataPath, 'regionalVarsRad_sfc_cld.mat']) % 'dR_cloudMask', 'dR_residualMask', 'dR_albMask', 'dR_husMask', 'dR_taMask', 'dR_tsMask'

    varUsed = zeros(nlonf, nlatf, ntime, 2);

    varUsed(:, :, :, 1) = dlwUPKernMask.world;
    varUsed(:, :, :, 2) = drhsMask.world;
    varNames = {'dR_{Ts}', 'dRHeating', 'ta RadEfect', 'ts RadEfect', 'q RadEfect', 'alb RadEfect'};
    yLabel = {'W/m2', 'W/m2', 'W/m2', 'W/m2', 'W/m2', 'W/m2'};

    sizeVarUsed = size(varUsed);
    sizeLon = sizeVarUsed(1); sizeLat = sizeVarUsed(2); sizeTime = sizeVarUsed(3); sizeVar = sizeVarUsed(4);
    varUsedYearly = varUsed;
    
    % transfor monthly data to the yearly data
    % varUsedYearly = zeros(sizeLon, sizeLat, sizeTime / 12, sizeVar);

    % for varNum = 1:sizeVar
    %     varUsedYearly(:, :, :, varNum) = monthlyToYearly(varUsed(:, :, :, varNum));
    % end

    % % detrend
    % for varNum = 1:sizeVar

    %     for latNum = 1:nlatf

    %         for lonNum = 1:nlonf
    %             varUsedYearly(lonNum, latNum, :, varNum) = detrend(squeeze(squeeze(varUsedYearly(lonNum, latNum, :, varNum))));
    %         end

    %     end

    % end

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

    headLineTxt = ['The correlation coefficient of LW_up and dRHeating, Level:', toaSfc{2}, '~C~            Era: ', level.time1{exmNum}(6:end - 1), ', MME code', MMECode, '~C~             global mean CC= ', num2str(cc_weightMean{2})];
    figName = [level.time1{exmNum}(5:end - 1), '_', MMECode];
    figurePath = [outputPath, '/', figName];
    colorLab = mycolor(18);
