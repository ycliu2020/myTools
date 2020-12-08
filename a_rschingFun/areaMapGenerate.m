%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-11-07 15:11:29
% LastEditTime : 2020-12-08 15:09:39
% LastEditors  : Please set LastEditors
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/areaMapGenerate.m
% symbol_custom_string_obkoro1:  
%%---------------------------------------------------------
clc; clear;
nowpath = pwd;

%% calculate mask file
% load mask map
load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_cp144.mat')% load word land mask
load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_ce72.mat')% load word land mask
load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/correct_worldmap.mat')
load('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/mat_file/mask14472.mat')
load('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/mat_file/中国干湿以及青藏高原分区地图/main_use/mask720.mat')
% 国境线
bou_china = shaperead('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/map_data/中国及各省shp/国界线/bou1_4p.shp'); % load china  boundary
bou_chinaX = [bou_china(:).X]; bou_chinaY = [bou_china(:).Y];
% 国境线(带南海线)
bou_china_line = shaperead('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/map_data/中国及各省shp/国界线/bou1_4l.shp'); % load china  boundary
bou_china_lineX = [bou_china_line(:).X]; bou_china_lineY = [bou_china_line(:).Y];
% 省界线
bou_chinaProvince = shaperead('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/map_data/中国及各省shp/省界线/bou2_4p.shp'); % load china  boundary
bou_chinaProvinceX = [bou_chinaProvince(:).X]; bou_chinaProvinceY = [bou_chinaProvince(:).Y];

% China east
maskchina_east = maskchina_cp;
maskchina_east(lonw < 112 | lonw > 122, :) = 0;
maskchina_east(:, latw > 37 | latw < 22) = 0;
readme_mask_CN_east = 'area of east China, Range: lonw>112E,latw<38N; Based on maskchina_cp(lon, lat same as it)';
save('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/mat_file/mask14472_east.mat', 'maskchina_east', 'lat14472', 'lon14472', 'readme_mask_CN_east')

% USA east
maskUSA_east = maskworld_cp;
maskUSA_east(lonw < -90 | lonw>-80, :) = 0;
maskUSA_east(:, latw < 30 | latw>45) = 0;
readme_mask_USA_east = 'area of east USA, Range: 288>lonw>276E,25<latw<45N; Based on maskworld_cp(lon, lat same as it)';
save('/home/liuyc/lib/tools/matlab/plot/myMap/03.other_area/mask14472_eastUSA.mat', 'maskUSA_east', 'lat14472', 'lon14472', 'readme_mask_USA_east')

% EUR west
maskEUR_west = maskworld_cp;
maskEUR_west(lonw >14 | lonw<-1, :) = 0;
maskEUR_west(:, latw < 42 | latw>54) = 0;
readme_mask_EUR_west = 'area of west EUR, Range: -1>lonw>15E,42<latw<55N; Based on maskworld_cp(lon, lat same as it)';
save('/home/liuyc/lib/tools/matlab/plot/myMap/03.other_area/mask14472_westEUR.mat', 'maskEUR_west', 'lat14472', 'lon14472', 'readme_mask_EUR_west')
