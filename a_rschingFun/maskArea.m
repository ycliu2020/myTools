%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-09 15:50:13
% LastEditTime : 2020-11-09 22:33:30
% LastEditors  : LYC
% Description  :
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/maskArea.m
%
%%---------------------------------------------------------
function [maskData, yr_cc, yr_pp] = maskArea(maskData, lat, maxlat, minlat, areaNum)
    %-------------------------------------------------------------------
    % program description(before use check the lat and lon)
    % 1.auto mask world or other area in 144x72 grids;
    % 2.cal the cc(compare first row);
    %-------------------------------------------------------------------
    % input:
    % maskData: input data(lon, lat, time)
    % areaNum: 0 no mask, 1 world land, 2 china land,
    % maxlat,minlat: lat scope;

    % load maskword file
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_cp144.mat')% load word land mask
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_ce72.mat')% load word land mask
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/correct_worldmap.mat')% ?
    load('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/mat_file/mask14472.mat')
    load('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/mat_file/mask14472_east.mat')
    load('/home/liuyc/lib/tools/matlab/plot/myMap/03.other_area/mask14472_eastUSA.mat')
    load('/home/liuyc/lib/tools/matlab/plot/myMap/03.other_area/mask14472_westEUR.mat')

    maskData=squeeze(maskData);
    sizeVar = size(maskData); 
    % mask
    if mean(areaNum == 1)==1 || strcmp(areaNum, 'world') == 1
        % mask word(land and lat:-60,60)
        mask1 = maskworld_cp;
    elseif mean(areaNum == 2)==1 || strcmp(areaNum, 'china') == 1
        mask1 = maskchina_cp;
    elseif mean(areaNum == 3)==1 || strcmp(areaNum, 'china east') == 1
        mask1 = maskchina_east;
    elseif strcmp(areaNum, 'USA east') == 1
        mask1 = maskUSA_east;
    elseif strcmp(areaNum, 'EUR west') == 1
        mask1 = maskEUR_west;
    end

    if areaNum == 0

    else
        mask_temp = repmat(mask1, [1 1 sizeVar(3)]);
        maskData(~mask_temp) = NaN;
        maskData(:, lat > maxlat | lat < minlat, :) = NaN;
        mask1 = maskworld_cp;
        mask_temp = repmat(mask1, [1 1 sizeVar(3)]);
        maskData(~mask_temp) = NaN;
        maskData(:, lat > maxlat | lat < minlat, :) = NaN;
    end

    % cal the cc
    yr_cc = cell(1, sizeVar(3));
    yr_pp = cell(1, sizeVar(3));

    for jj = 1:sizeVar(3)
        [cc0, pp0] = corrcoef(maskData(:, :, 1), maskData(:, :, jj), 'Rows', 'complete');
        yr_cc{jj} = roundn(cc0(1, 2), -2); %保留俩位小数
        yr_pp{jj} = pp0(1, 2); % confidence interval

    end
