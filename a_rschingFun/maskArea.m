%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-09 15:50:13
% LastEditTime : 2020-06-12 09:09:18
% LastEditors  : LYC
% Description  : 
% FilePath     : /Research/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/maskArea.m
%  
%%---------------------------------------------------------
function [trendyr, yr_cc, yr_pp] = maskArea(trendyr,lat, maxlat,minlat,areaNum)
    %-------------------------------------------------------------------
    % program description(before use check the lat and lon)
    % 1.auto mask world or other area in 144x72 grids;
    % 2.cal the cc(compare first row);
    %-------------------------------------------------------------------
    % input:
    % trendyr: input data
    % areaNum: 0 no mask, 1 world land, 2 china land,
    % maxlat,minlat: lat scope;

    % load maskword file
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_cp144.mat')% load word land mask
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_ce72.mat')% load word land mask
    load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/correct_worldmap.mat')% ????????????????word_mapx(:),word_mapy(:)
    load('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/mat_file/mask14472.mat')
    
    sizeVar=size(trendyr);
    % mask
    if areaNum==1
        % mask word(land and lat:-60,60)
        mask1=maskworld_cp;
    elseif areaNum==2
        mask1=maskchina_cp;
    end
    if areaNum==0

    else
        mask_temp=repmat(mask1,[1 1 sizeVar(3)]);
        trendyr(~mask_temp)=NaN;
        trendyr(:,lat>maxlat|lat<minlat,:)=NaN;
        mask1 = maskworld_cp;
        mask_temp = repmat(mask1, [1 1 sizeVar(3)]);
        trendyr(~mask_temp) = NaN;
        trendyr(:, lat > maxlat | lat < minlat, :) = NaN;
    end

    % cal the cc
    yr_cc=cell(1,sizeVar(3));
    yr_pp=cell(1,sizeVar(3));
    for jj = 1 : sizeVar(3)
        [cc0,pp0] = corrcoef(trendyr(:,:,1),trendyr(:,:,jj),'Rows','complete');
        yr_cc{jj}=roundn(cc0(1,2),-2);%������λС��
        yr_pp{jj} = pp0(1,2);% confidence interval
    
    end




