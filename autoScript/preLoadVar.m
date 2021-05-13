%%---------------------------------------------------------
% Author       : LYC
% Date         : 2021-04-22 10:39:24
% LastEditors  : Please set LastEditors
% Description  : usage:  run '/home/liuyc/lib/tools/matlab/myTools/autoScript/preLoadVar.m'
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/autoScript/preLoadVar.m
%  
%%---------------------------------------------------------
% load mask map
load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_cp144.mat') % load word land mask
load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_ce72.mat') % load word land mask
load('/home/liuyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/correct_worldmap.mat')
load('/home/liuyc/lib/tools/matlab/plot/myMap/01.china_map/mat_file/mask14472.mat')

latRange = 90; % Latitude range
lon1 = [2.5 357.5]; lat1 = [-latRange + 1 latRange - 1]; % world area
toaSfc = {'toa', 'sfc'};
lon_k = 0:2.5:357.5; nlonk = length(lon_k); % kernel lat lon
lat_k = 90:-2.5:-90; nlatk = length(lat_k);
lat_f = 88.75:-2.5:-88.75; nlatf = length(lat_f); % figure lat lon
lon_f = lon_k; nlonf = length(lon_f);

%% cal intersection of AMIP and SSP370
exmMdlAMIP2000 = onlySee_ripf1(1); % amip
exmMdlSSP370 = onlySee_ripf1(4); % ssp370

[MME_Models.name, exmMdlAMIP2000.index, exmMdlSSP370.index] = intersect(exmMdlAMIP2000.name', exmMdlSSP370.name');
MME_Models.readme = 'This essmble set contains the intersect of AMIP and SSP370, i.e., the total of 9 models';
