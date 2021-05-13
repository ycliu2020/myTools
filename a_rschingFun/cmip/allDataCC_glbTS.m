%%---------------------------------------------------------
% Author       : LYC
% Date         : 2021-05-12 21:28:26
% LastEditors  : Please set LastEditors
% Description  :
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/cmip/allDataCC_glbTS.m
%
%%---------------------------------------------------------
function [lon_f, lat_f, cc_glbSet, figTitle, figPath, colorLab] = allDataCC_glbTS(MMEType, ERAType)
    run '/home/liuyc/lib/tools/matlab/myTools/autoScript/preLoadVar.m'
    
    % [mlabels, ~] = obsPlotParameters('sfc', 'land', 'ERA5-radEffect-ts');
    [readme, level, tLin, vars] = obsParameters(ERAType);

    cc_glbSet=zeros(nlonf, nlatf, 2, 3);% ERA, AMIP, SSP370
    % ERA and AMIP only contain 2000-2014
    %% cal ERA part
    ERAPath = fullfile('/data2/liuyincheng/Observe-process', tLin.time{4}, ERAType);
    varsPath = fullfile(ERAPath, level.standVarPath{1}); %rawdata
    dvarsPath = fullfile(ERAPath, level.standVarPath{2}); %anomaly
    radEffectPath = fullfile(ERAPath, level.standVarPath{5}); %radEffect

    load([radEffectPath, 'global_vars.mat']) % % 'lon_f', 'lat_f', 'lon_k', 'lat_k', 'plev_k', 'time'
    load([radEffectPath, 'dradEffect_sfc_cld.mat']) % load albEffect, husEffect, mainEffect, taEffect, taOnlyEffect, taOnlyEffect2, tasEffect, tasEffect2, totalEffect, tsEffect, wvlwEffect, wvswEffect
    load([dvarsPath, 'drhs.mat']) % load drhs
    ntime = length(time);
    % regrid
    drhs = autoRegrid3(lon_k, lat_k, time, drhs, lon_f, lat_f, time);
    % save in one var
    varUsed = zeros(nlonf, nlatf, ntime, 2);
    varUsed(:, :, :, 1) = -tsEffect;
    varUsed(:, :, :, 2) = drhs;

    sizeVarUsed = size(varUsed);
    sizeLon = sizeVarUsed(1); sizeLat = sizeVarUsed(2); sizeTime = sizeVarUsed(3); sizeVar = sizeVarUsed(4);

    % mask
    for varNum = 1:sizeVar
        [varUsed(:, :, :, varNum), ~, ~] = maskArea(squeeze(varUsed(:, :, :, varNum)), lat_f, latRange, -latRange, 'world');
    end
    
    % cal CC of weight mean and each point
    [cc_weightMean, pp_weightMean] = calCCofWeiMean(varUsed, sizeTime, sizeVar, lat_f);
    [cc_glb,pp_glb] = calCCofEachPoint(varUsed, sizeTime, sizeVar, nlatf, nlonf);
    cc_glbSet(:,:,:,1)=cc_glb;
    ccNum=2;

    %% cal MME part
    MMENum = str2num(MMEType(end));

    for exmNum = [1 4]
        [mlabels, areaNum] = cmipPlotParameters('sfc', 'land', 'radEffect'); % plot parameters
        [readme, Experiment, level, tLin, mPlev, vars] = cmipParameters(exmNum);
        % MMEPath
        MMEPath = fullfile(level.path_MME, MMEType, level.time1{exmNum}); %/data1/liuyincheng/CMIP6-process/2000-2014/
        figDataPath = fullfile(MMEPath, 'FigData/');
        % data path
        dvarsPath = fullfile(MMEPath, level.process3{2}); %/data1/liuyincheng/CMIP6-process/2000-2014/MRI-ESM2-0/anomaly
        dradEffectPath = fullfile(MMEPath, level.process3{6}); %/data1/liuyincheng/CMIP6-process/2000-2014/MRI-ESM2-0/radEffect/

        load([dradEffectPath, 'global_vars.mat']) % lat_f lon_f time plev_k readme
        ntime = length(time.date);

        % load Data
        load([figDataPath, 'regionalVarsRad_sfc_cld.mat']) % 'dR_cloudMask', 'dR_residualMask', 'dR_albMask', 'dR_husMask', 'dR_taMask', 'dR_tsMask'
        varUsed = zeros(nlonf, nlatf, ntime, 2);
        varUsed(:, :, :, 1) = dlwUPKernMask.world;
        varUsed(:, :, :, 2) = drhsMask.world;
        sizeVarUsed = size(varUsed);
        sizeLon = sizeVarUsed(1); sizeLat = sizeVarUsed(2); sizeTime = sizeVarUsed(3); sizeVar = sizeVarUsed(4);
        % cal CC of weight mean and each point
        [cc_weightMean, pp_weightMean] = calCCofWeiMean(varUsed, sizeTime, sizeVar, lat_f);
        [cc_glb,pp_glb] = calCCofEachPoint(varUsed, sizeTime, sizeVar, nlatf, nlonf);
        cc_glbSet(:,:,:,ccNum)=cc_glb;
        ccNum=ccNum+1;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % plot Part
    f_row = 3; f_col = 1; % 设置画图的行列
    figTitle.subTitle=cell(1, f_row*f_col);
    figTitle.subTitle = {[ERAType, ' 2000-2014'],['AMIP 2000-2014'],['SSP370 2015-2099']};
    figTitle.headLineTxt = ['The correlation coefficient of LW_up and dRHeating~C~            MME Type: ', MMEType, ', ERA Data: ', ERAType, ', Level: ', mlabels.level];
    figTitle.seqNum=cell(1, f_row*f_col);
    for rowNum = 1:f_row*f_col
        figTitle.seqNum{rowNum}=['(', char(96 + rowNum), ')'];
    end

    colorLab = mycolor(18);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% save Part
    mPath.outPut = fullfile('/home/liuyc/Research/P02.Ts_change_research/figure/figOfSketch/TimeSeries/glbTS_cc/'); %['dRTs_', lower(mlabels.level)],
    auto_mkdir(mPath.outPut)
    figName = [MMEType,'_glbTS_cc_', level.time1{exmNum}(6:end - 11)]; %num2str(plotType),'Plot'
    figPath = [mPath.outPut, '/', figName];


end

function [cc_weightMean, pp_weightMean] = calCCofWeiMean(varUsed, sizeTime, sizeVar, lat_f)
    % cal areaMeanLatWeight
    varUsed_weightMean = zeros(sizeTime, sizeVar);

    for varNum = 1:sizeVar

        for timeNum = 1:sizeTime
            varUsed_weightMean(timeNum, varNum) = areaMeanLatWeight(varUsed(:, :, timeNum, varNum), lat_f);
        end

    end

    % cal cc of areaMeanLatWeight
    sizeWeightMean = size(varUsed_weightMean);
    cc_weightMean = cell(1, sizeWeightMean(2));
    pp_weightMean = cell(1, sizeWeightMean(2));

    for varNum = 1:sizeWeightMean(2)
        [cc0, pp0] = corrcoef(varUsed_weightMean(:, 1), varUsed_weightMean(:, varNum), 'Rows', 'complete');
        cc_weightMean{varNum} = roundn(cc0(1, 2), -2); %保留俩位小数
        pp_weightMean{varNum} = pp0(1, 2); % confidence interval
    end

end

function [cc_glb,pp_glb] = calCCofEachPoint(varUsed, sizeTime, sizeVar, nlatf, nlonf)
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % cal cc of every point of map
    cc_glb = zeros(nlonf, nlatf, sizeVar);
    pp_glb = zeros(nlonf, nlatf, sizeVar);

    for varNum = 1:sizeVar

        for latNum = 1:nlatf

            for lonNum = 1:nlonf
                varUsedTemp = squeeze(squeeze(varUsed(lonNum, latNum, :, :)));
                [cc0, pp0] = corrcoef(varUsed(lonNum, latNum, :, 1), varUsed(lonNum, latNum, :, varNum), 'Rows', 'complete');
                cc_glb(lonNum, latNum, varNum) = roundn(cc0(1, 2), -2); %保留俩位小数
                pp_glb(lonNum, latNum, varNum) = pp0(1, 2); % confidence interval
            end

        end

    end

end

