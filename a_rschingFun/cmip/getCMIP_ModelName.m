%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-10-14 15:3nValue:49
% LastEditTime : ,: 2020-10-22 16:51:48
% LastEditors  : ,: LYC
% Description  : get all model name in all experient (only calculate r1i1p1f1)
% FilePath     : ,: /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/cmip/getCMIP_ModelName.m
%  
%%---------------------------------------------------------
clc; clear;
nowpath = pwd;

exmStart = 1; exmEnd = 4;


for exmNum = exmStart:exmEnd
    [readme, Experiment, level, tLin, mPlev, vars] = cmipParameters(exmNum);
    % mPath.input:E:/data/cmip6-process/2000-2014/
    exmPath = fullfile('/data1/liuyincheng/cmip6-process/', level.time1{exmNum});

    % save model in one value
    Total_modelName = zeros(1, 2);
    Total_modelName = string(Total_modelName);
    Timer_modelName = 0;
    % model loop
    mdlStart = 1; mdlEnd = length(level.model2); % differnt models%length(level.model2)
    for mdlNum = mdlStart:mdlEnd

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
            % disp(['the ', esm, ' ensemble of ', mdlName, ' didnt exist']);
            continue
        end
        Timer_modelName = Timer_modelName+1;
        specificNum = find(strcmp(esmName, 'r1i1p1f1') == 1);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % ensemble member
        Total_modelName(Timer_modelName)=level.model2{mdlNum};

    end

    disp([level.time1{exmNum}, ':'])
    disp(join(Total_modelName))
end

eval(['cd ', nowpath]);


