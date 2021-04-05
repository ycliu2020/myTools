%%---------------------------------------------------------
% Author       : LYC
% Date         : 2021-04-02 16:29:53
% LastEditors  : Please set LastEditors
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/cmip/onlySee_ripf1.m
%  
%%---------------------------------------------------------
function exmMdl = onlySee_ripf1(exmNum)
    %myFun - Description
    % exmNum: 实验序号
    % exmMdl: 包含r1i1p1f1 ensemble member 的实验名/路径
    %
    % Long description
    nowpath = pwd;

    exmMdl = {};
    Num_exmMdl = 1;
    [readme, Experiment, level, tLin, mPlev, vars] = cmipParameters(exmNum);
    % path
    exmPath = ['/data1/liuyincheng/CMIP6-process/', level.time1{exmNum}]; %/data1/liuyincheng/cmip6-process/2000-2014/
    % find model exist r1i1p1f1 or not
    for mdlNum = 1:length(level.model2) %1:length(level.model2)
        % model path
        mdlName = level.model2{mdlNum};
        mdlPath = fullfile(exmPath, level.model2{mdlNum});
        eval(['cd ', mdlPath]);

        % ensemble member path
        esmName = getPath_fileName(mdlPath, '.');

        %% 暂时只看esm实验
        esm = 'r1i1p1f1';

        if sum(strcmp(esmName, esm)) == 0
            continue
        end

        specificNum = find(strcmp(esmName, 'r1i1p1f1') == 1);
        exmMdl.name{Num_exmMdl} = mdlName;
        exmMdl.path{Num_exmMdl} = mdlPath;
        exmMdl.esmPath{Num_exmMdl} = fullfile(mdlPath, 'r1i1p1f1');
        Num_exmMdl = Num_exmMdl + 1;
    end
    eval(['cd ', nowpath]);

end