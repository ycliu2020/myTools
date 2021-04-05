%%---------------------------------------------------------
% Author       : LYC
% Date         : 2021-04-05 19:50:39
% LastEditors  : Please set LastEditors
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/cmip/MME_autoCal.m
%  
%%---------------------------------------------------------
function [] = MME_autoCal(varsOrig, MME_Models, exmNum)
    %MME_autoCal - Description
    %
    % Syntax: [] = MME_autoCal(input)
    %
    % Long description
    % varsOrig: vars need to be caled, contain information of Name, fileFolder, fileName, outputPath like example:
    % varsOrig.Name={'taEffect','albEffect','husEffect'};
    % varsOrig.fileFolder='radEffect/';
    % varsOrig.fileName='dradEffect_sfc_cld.mat';
    % varsOrig.outputPath='/data1/liuyincheng/CMIP6-process/z_ensembleMean/MME1/'
    % MME_Models: main contains model names
    % exmNum: the number of experiments

    %% cal MME
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    nowpath = pwd;
    [readme, Experiment, level, tLin, mPlev, vars] = cmipParameters(exmNum);
    % exmPath
    exmPath = ['/data1/liuyincheng/CMIP6-process/', level.time1{exmNum}]; %/data1/liuyincheng/cmip6-process/2000-2014/

    level.model2 = {};
    level.model2 = MME_Models.name;

    % length(level.model2)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % model
    for mdlNum = 1:length(level.model2) %1:length(level.model2)
        % model path
        mdlName = level.model2{mdlNum};
        mdlPath = fullfile(exmPath, level.model2{mdlNum});
        eval(['cd ', mdlPath]);

        % ensemble member path
        esmName = getPath_fileName(mdlPath, '.');
        eval(['cd ', nowpath]);

        %% 暂时只看esm实验
        esm = 'r1i1p1f1';

        if sum(strcmp(esmName, esm)) == 0
            disp(['the ', esm, ' ensemble of ', mdlName, ' didnt exist']);
            continue
        end

        specificNum = find(strcmp(esmName, 'r1i1p1f1') == 1);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % ensemble member
        for esmNum = specificNum:specificNum %1:1 %length(esmName) % note that r1i1p1 sometime not the first folder
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% load and read
            esmPath = fullfile(mdlPath, esmName{esmNum, 1}); % r1i1p1f1 path

            % load global_vars
            dradEffectPath = fullfile(esmPath, level.process3{6}); %/data1/liuyincheng/cmip6-process/2000-2014/MRI-ESM2-0/radEffect/
            load([dradEffectPath, 'global_vars.mat']) % lat_f lon_f time plev_k readme

            % save information of time
            ntime = length(time.date);
            timeEssmble.date(:, mdlNum) = time.date;
            timeEssmble.Units{mdlNum, :} = time.Units;
            timeEssmble.Calendar{mdlNum, :} = time.Calendar;

            % load select vars
            [~, process3_index, ~] = intersect(level.process3, varsOrig.fileFolder);
            varsOrig.Path = fullfile(esmPath, level.process3{process3_index}); %/data1/liuyincheng/cmip6-process/2000-2014/MRI-ESM2-0/radEffect/
            load([varsOrig.Path, varsOrig.fileName])

            % test var exist or not, it will warning if var didnt exist
            for varsNum = 1:length(varsOrig.Name)

                if ~exist(varsOrig.Name{varsNum}, 'var')
                    disp(['the var ', varsOrig.Name{varsNum}, ' didnt exist in ', varsOrig.fileName])
                    return
                end

            end

            % add all vars in on var, default format of vars is 3-D
            for varsNum = 1:length(varsOrig.Name)
                singleVarUsed(:, :, :, varsNum) = eval(varsOrig.Name{varsNum});
            end

        end % esmNum

        essembleVarUsed(:, :, :, :, mdlNum) = singleVarUsed;
        mdlNum = mdlNum + 1;

    end % modelNum

    %% test time consistance or not (not finish)

    %% test nan data exist or not
    decideNan = isnan(essembleVarUsed);

    while ~all(decideNan == 0)
        disp('Nan exist in Data')
        return
    end

    %% cal essemble mean and save files
    essembleMeanVar = mean(essembleVarUsed, 5);
    % 转换原变量名
    for varsNum = 1:length(varsOrig.Name)
        eval([varsOrig.Name{varsNum}, '=squeeze(essembleMeanVar(:,:,:,', num2str(varsNum), '));'])
    end

    outPutPath = [varsOrig.outputPath, level.time1{exmNum}, varsOrig.fileFolder];
    auto_mkdir(outPutPath);
    outPutFileName = [outPutPath, varsOrig.fileName];

    % save global_vars
    save([outPutPath, 'global_vars.mat'], 'lon_f', 'lat_f', 'timeEssmble', 'time', 'plev_k', 'readme', 'timeseries', 'MME_Models')

    % save respective vars
    saveRlue = join(strcat('^', varsOrig.Name, '$|'), '');
    save(outPutFileName, '-regexp', saveRlue{1})

end
