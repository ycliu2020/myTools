%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-09 15:50:13
% LastEditTime : 2020-07-13 14:26:45
% LastEditors  : LYC
% Description  :
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/cmip/cmipParameters.m
%
%%---------------------------------------------------------
function [readme, Experiment, level, tLin, mPlev, vars] = cmipParameters(p_1)
    % By liuyincheng (ycliu@smail.nju.edu.cn)
    % purpose: auto output model's parameters, so we only need to modify once if something change.
    %
    % p_1: input, determine which experiment to cal
    % startyear:choose which year to start
    % endyear:choose which year to end
    % startmon:choose which month to start

    %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    % edit the guidence
    readme.v3 = 'v3 mean 3D vars';
    readme.v4 = 'v4 mean 4D vars';
    readme.readme = 'this struct is the guidence of the vars in the matfile';
    readme.model_vars = 'contain 16 vars:hus, ta, ts, ps, rlds, rldscs, rlus, rlut, rlutcs, rsds, rsdscs, rsdt,rsus, rsuscs, rsut, rsutcs, maybe more or less in the furture';
    readme.time_note = 'data is monthly mean if no special illustration. time vars standard: days since 0001-01-01 00:00:00, already use matlab transform';
    readme.global_vars = 'lonf, latf, time, plevf are the global vars';
    %+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    % attention(2020/6/29): 模型仅包含能够计算云辐射效应变量的模式, 可能还会缺少ua, va, wa等其他变量
    modlist_all = ...
        {{'ACCESS-CM2', 'ACCESS-ESM1-5', 'BCC-CSM2-MR', 'BCC-ESM1', 'CanESM5', 'CAS-ESM2-0', 'CESM2', 'CESM2-FV2', 'CESM2-WACCM', 'CESM2-WACCM-FV2', 'FGOALS-g3', 'GISS-E2-1-G', 'GISS-E2-2-G', 'HadGEM3-GC31-LL', 'HadGEM3-GC31-MM', 'MIROC6', 'MIROC-ES2L', 'MPI-ESM1-2-HR', 'MRI-ESM2-0', 'NESM3', 'NorCPM1', 'SAM0-UNICON', 'UKESM1-0-LL'}, ...
        ...amip_2000(23)'GISS - E2 - 1 - G / ',
    {'ACCESS-CM2', 'ACCESS-ESM1-5', 'BCC-CSM2-MR', 'BCC-ESM1', 'CanESM5', 'CAS-ESM2-0', 'CESM2', 'CESM2-FV2', 'CESM2-WACCM', 'CESM2-WACCM-FV2', 'FGOALS-g3', 'GISS-E2-1-G', 'GISS-E2-2-G', 'HadGEM3-GC31-LL', 'HadGEM3-GC31-MM', 'MIROC6', 'MIROC-ES2L', 'MPI-ESM1-2-HR', 'MRI-ESM2-0', 'NESM3', 'NorCPM1', 'SAM0-UNICON', 'UKESM1-0-LL'}, ...
        ...amip_1980(23)'GISS - E2 - 1 - G / ',
    {'ACCESS-CM2', 'ACCESS-ESM1-5', 'AWI-CM-1-1-MR', 'BCC-CSM2-MR', 'CanESM5', 'CESM2', 'CESM2-WACCM', 'FGOALS-g3', 'GISS-E2-1-G', 'HadGEM3-GC31-LL', 'MIROC6', 'MIROC-ES2L', 'MPI-ESM1-2-HR', 'MPI-ESM1-2-LR', 'MRI-ESM2-0', 'NESM3', 'UKESM1-0-LL'}, ...
        ...ssp245(17)
    {'ACCESS-CM2', 'ACCESS-ESM1-5', 'AWI-CM-1-1-MR', 'BCC-CSM2-MR', 'CanESM5', 'CanESM5-CanOE', 'CESM2', 'CESM2-WACCM', 'FGOALS-g3', 'GISS-E2-1-G', 'MIROC6', 'MIROC-ES2L', 'MPI-ESM1-2-HR', 'MPI-ESM1-2-LR', 'MRI-ESM2-0', 'UKESM1-0-LL'}, ...
        ...ssp370(16)
    {'AWI-CM-1-1-MR', 'BCC-CSM2-MR', 'BCC-ESM1', 'CanESM5', 'CESM2', 'CESM2-WACCM', 'GISS-E2-1-G', 'GISS-E2-1-H', 'GISS-E2-2-G', 'MIROC6', 'MPI-ESM1-2-HR', 'MRI-ESM2-0', 'NESM3', 'SAM0-UNICON'}, ...
        ...abrupt - 4xCO2(14)
    {'CESM2', 'BCC-CSM2-MR', 'MIROC6', 'MRI-ESM2-0'}, ...
        ...amip - hist_2000(4)
    {'CESM2', 'BCC-CSM2-MR', 'MIROC6', 'MRI-ESM2-0'}, ...
        ...amip - hist_1980(4)
    {'AWI-CM-1-1-MR', 'BCC-CSM2-MR', 'BCC-ESM1', 'CanESM5', 'CESM2', 'CESM2-WACCM', 'GISS-E2-1-G', 'GISS-E2-1-H', 'GISS-E2-2-G', 'MIROC6', 'MPI-ESM1-2-HR', 'MRI-ESM2-0', 'NESM3', 'NorCPM1', 'SAM0-UNICON'}};
    % picmtrol(25)
    % {'ACCESS-CM2', 'AWI-CM-1-1-MR', 'BCC-CSM2-MR', 'BCC-ESM1', 'CanESM5', 'CESM2', 'CESM2-FV2', 'CESM2-WACCM', 'CESM2-WACCM-FV2', 'FGOALS-g3', 'FIO-ESM-2-0', 'GISS-E2-1-G', 'GISS-E2-1-G-CC', 'GISS-E2-1-H', 'GISS-E2-2-G', 'HadGEM3-GC31 'GISS-E2-2-G', 'HadGEM3-GC31-LL', 'HadGEM3-GC31-MM', 'MIROC6', 'MPI-ESM-1-2-HAM', 'MPI-ESM1-2-HR', 'MRI-ESM2-0', 'NESM3', 'NorCPM1', 'NorESM1-F', 'SAM0-UNICON'}
    % old amip
    % {'ACCESS-CM2', 'ACCESS-ESM1-5', 'BCC-CSM2-MR', 'BCC-ESM1', 'CanESM5', 'CESM2', 'CESM2-WACCM', 'FGOALS-g3', 'GISS-E2-1-G', 'MIROC6', 'MPI-ESM1-2-HR', 'MRI-ESM2-0', 'NESM3', 'NorCPM1', 'SAM0-UNICON'}, ...
    Experiment = {'amip/CMIP', 'amip/CMIP', 'ssp245', 'ssp370', 'abrupt-4xCO2', 'amip-hist', 'amip-hist'};

    level.time1 = {'amip_2000-2014/', 'amip_1980-2014/', 'ssp245_2015-2099/', 'ssp370_2015-2099/', ...
        'abrupt-4xCO2_150years/', ...
        'amip-hist_2000-2014/', 'amip-hist_1980-2014/'}; % time series
    level.model2 = modlist_all{p_1}; % model list
    level.process3 = {'rawdata_regrid/', 'anomaly/', 'anomaly_trend/', 'cc/', 'kernelsCal/', ...
        'radEffect/', 'radEffect_trend/', 'non_localCld/', 'vsTsEffect/', 'vsTsEffect_trend/'}; % next file folder names(use standVarPath Replace the current name)
    level.dvars4 = {'dhus', 'dalb', 'dta', 'dts'}; % note 5 kernels

    % time:2000.01-2014.12(interval:15*12);1980.01-2014.12(interval:35*12); 2015.01-2099.12(interval:85*12)
    % initial time in amip(432 total): 253 of 432(2000.03);13 of 432(1980.01);
    % initial time in futrue(1032 total): 1 of 1032(2015.01);
    % initial time in amip-hist(1740 total): 1,561 of 1740(2000.03);1,321 of 1740(1980.01);

    %% time line (tLin)
    tLin.time = {'2000-2014', '1980-2014', '2015-2099', '2015-2099', '1850-1999(standard)', '2000-2014', '1980-2014'}; % initial and last year
    tLin.read = {'2000.01-2014.12', '1980.01-2014.12', '2015.01-2099.12', '2015.01-2099.12', '1850.01-1999.12(standard)', '2000.01-2014.12', '1980.01-2014.12'}; % txt information '2000.03-2014.02', '1979.03-2014.02'
    tLin.start = {'2000-01', '1980-01', '2015-01', '2015-01', '1850-01', '2000-01', '1980-01'}; % start year
    tLin.startYear = {2000, 1980, 2015, 2015, 1850, 2000, 1980}; % start year
    tLin.endYear = {2014, 2014, 2099, 2099}; % start year(note that 4xco2 not have endyear)
    tLin.inter = {15 * 12 35 * 12 85 * 12 85 * 12 150 * 12 15 * 12 35 * 12}; % total months
    % tLin.start = [253 13 1 1 1561 1321];

    %% pleve test
    mPlev.units = {'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa', 'Pa'};
    mPlev.wards = {'down', 'down', 'down', 'down', 'down', 'down', 'down'};
    mPlev.length = {19, 19, 19, 19, 19, 19, 19}; % length(plev)
    mPlev.maxx = {10e4, 10e4, 10e4, 10e4, 10e4, 10e4, 10e4};
    mPlev.minn = {100, 100, 100, 100, 100, 100, 100};
    %% vars name
    vars.all = {'hus', 'ta', ...
        'ts', 'ps', 'rlds', 'rldscs', 'rlus', 'rlut', 'rlutcs', 'rsds', 'rsdscs', 'rsdt', ...
        'rsus', 'rsuscs', 'rsut', 'rsutcs', 'hfss', 'hfls', 'clisccp'};
    vars.D3 = {'ts', 'ps', 'rlds', 'rldscs', 'rlus', 'rlut', 'rlutcs', 'rsds', 'rsdscs', 'rsdt', ...
        'rsus', 'rsuscs', 'rsut', 'rsutcs', 'hfss', 'hfls', 'clisccp'};
    vars.D4 = {'hus', 'ta'};
    vars.lamda = {'cloud', 'wv', 'ta', 'alb'};

    % Coordinate Information
    % % kernel Coordinate
    % lon_k = 0:2.5:357.5; nlonk = length(lon_k);
    % lat_k = 90:-2.5:-90; nlatk = length(lat_k);
    % % plot figure Coordinate
    % lat_f = 88.75:-2.5:-88.75; nlatf = length(lat_f);
    % lon_f = lon_k; nlonf = length(lon_f);
    % % ceres Coordinate
    % lon_c = 0.5:1:359.5; nlonc = length(lon_c); lon_c = double(lon_c);
    % lat_c = -89.5:1:89.5; nlatc = length(lat_c); lat_c = double(lat_c);
