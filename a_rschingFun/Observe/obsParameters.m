%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-09 15:50:13
% LastEditTime : 2021-04-06 09:44:12
% LastEditors  : Please set LastEditors
% Description  :
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/Observe/obsParameters.m
%
%%---------------------------------------------------------
function [readme, level, tLin, vars] = obsParameters(dataName)
    % By liuyincheng (ycliu@smail.nju.edu.cn)
    % purpose: auto output observe data parameters, so we only need to modify once if something change.
    % p_1 mean: 1.2000-03 to 2018-02(18*12) 2.200207-201706(15*12)

    %% level: 文件结构层次
    level.standVarPath = {'rawdata_regrid/', 'anomaly/', 'anomaly_trend/', 'kernelsCal/', ...
        'radEffect/', 'radEffect_trend/'};
    level.dataSet = {'ERAi/', 'ERA5/', 'CERES/', 'MODIS/','HadCRUT4/'}; % 不同的资料名称

    %% time line (tLin)
    tLin.time = {'200003-201802', '200207-201706', '200003-201402','200001-201412','198001-201412'}; % initial and last year
    tLin.start = {'2000-03', '2002-07','2000-03','2000-01','1980-01'}; % start year
    tLin.inter = {18 * 12 15 * 12 14*12 15*12 35*12}; % total months
    tLin.startMonth = {3 7 3 1 1}; % start months

    %% readme
    readme.readme = 'this is erai vars data all sky and clear sky drad ';
    readme.vars = 'including albeo, ts, water, ta ';

    %% vars name    
    if strcmp(dataName, 'ERA5') == 1 || strcmp(dataName, 'era5') == 1
        vars.all = {'skt', 'fal', 'sp' ...
            't', 'q' ...
            'tsr', 'ttr', 'tsrcs', 'ttrcs' ...
            'slhf', 'sshf', 'ssr', 'str', 'strd', 'ssrd', 'ssrc', 'strc', 'strdc', 'ssrdc'};
        vars.Rad = {'tsr', 'ttr', 'tsrcs', 'ttrcs', 'slhf', 'sshf', 'ssr', 'str', 'strd', 'ssrd', 'ssrc', 'strc', 'strdc', 'ssrdc'};
        vars.toaRad = {'tsr', 'ttr', 'tsrc', 'ttrc'};
        vars.sfcRad = {'slhf', 'sshf', 'ssr', 'str', 'strd', 'ssrd', 'ssrc', 'strc', 'strdc', 'ssrdc'};
        vars.meto3D = {'skt', 'fal', 'sp'};
        vars.meto4D = {'t', 'q'};
    elseif strcmp(dataName, 'ERAi') == 1 || strcmp(dataName, 'erai') == 1
        vars.all = {'skt', 'fal', 'sp' ...
            't', 'q' ...
            'tsr', 'ttr', 'tsrcs', 'ttrcs' ...
            'slhf', 'sshf', 'ssr', 'str', 'strd', 'ssrd', 'ssrc', 'strc'};
        vars.Rad = {'tsr', 'ttr', 'tsrcs', 'ttrcs', 'slhf', 'sshf', 'ssr', 'str', 'strd', 'ssrd', 'ssrc', 'strc'};
        vars.toaRad = {'tsr', 'ttr', 'tsrc', 'ttrc'};
        vars.sfcRad = {'slhf', 'sshf', 'ssr', 'str', 'strd', 'ssrd', 'ssrc', 'strc'};
        vars.meto3D = {'skt', 'fal', 'sp'};
        vars.meto4D = {'t', 'q'};
    else
        vars=[];
    end

end
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