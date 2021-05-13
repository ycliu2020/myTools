%%---------------------------------------------------------
% Author       : LYC
% Date         : 2021-04-14 10:15:05
% LastEditors  : Please set LastEditors
% Description  : 通过shp文件生成mask文件
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/dataProcess/shpMask.m
%  
%%---------------------------------------------------------
clear
shpInput='/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/map_data/青藏高原/';
demoDataPath='/data1/liuyincheng/Observe-process/200001-201412/ERA5/radEffect/';
% Mask Part
load([demoDataPath,'global_vars.mat']) %lat_f, lat_k, lon_f, lon_k, plev_k, time

shpData=shaperead([shpInput,'/DBATP_Polygon.shp']);% 读取国界shp文件，a为结构体。输入whos a 可查看结构体
lon_shpData=[shpData(:).X];% 提取经度
lat_shpData=[shpData(:).Y];% 提取纬度

[lon1, lat1]=meshgrid(lon_f,lat_f);

mask144_DBATP=(inpolygon(lon1,lat1,lon_shpData,lat_shpData))';%注意是转置矩阵

% test Part
load([demoDataPath,'dCRF.mat']) 
testData= dCRF(:,:,1,1);
testData(~mask144_DBATP)=NaN;
figure
contourf(lon1,lat1,testData',30);


% %% exclude DBATP
% load('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/mat_file/mask14472.mat')% maskchina_cp
% maskchina_cp(mask144_DBATP==1)=0;
% testData= dCRF(:,:,1,1);
% testData(~maskchina_cp)=NaN;

% figure
% contourf(lon1,lat1,testData',30);

% mask144_excludDBATP=maskchina_cp;
