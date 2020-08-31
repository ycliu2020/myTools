%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-07-28 11:09:16
% LastEditTime : 2020-08-17 18:26:15
% LastEditors  : LYC
% Description  : Latitude weighted average
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/areaMeanLatWeight.m
%
%%---------------------------------------------------------
function [varMean] = areaMeanLatWeight(varInput, lat)
    % data must be (lon, lat)
    jiaquan = cosd(lat);
    sizeVar = size(varInput);
    weight = ones(sizeVar(1), sizeVar(2));

    for latNum = 1:sizeVar(2)
        weight(:, latNum) = weight(:, latNum)* jiaquan(latNum); %格点相对大小
    end

    varUse = varInput .* weight;
    varMean = nansum(nansum(varUse)) / nansum(nansum(weight));
