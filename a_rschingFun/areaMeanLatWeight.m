%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-07-28 11:09:16
% LastEditTime : 2020-11-02 15:27:24
% LastEditors  : LYC
% Description  : Latitude weighted average
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/areaMeanLatWeight.m
%
%%---------------------------------------------------------
function [varMean] = areaMeanLatWeight(varInput, lat)
    % data must be (lon, lat)
    % varMean: 
    varInput=squeeze(squeeze(varInput));
    jiaquan = cosd(lat);
    sizeVar = size(varInput);
    weight = ones(sizeVar(1), sizeVar(2));
    
    weight(isnan(varInput))=nan;
    for latNum = 1:sizeVar(2)
        weight(:, latNum) = weight(:, latNum)* jiaquan(latNum); %格点相对大小
    end

 
    varUse = varInput .* weight;
    varMean = nansum(nansum(varUse)) / nansum(nansum(weight));
