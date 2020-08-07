%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-08-03 15:17:30
% LastEditTime : 2020-08-03 21:26:29
% LastEditors  : LYC
% Description  : 
% FilePath     : /code/tempCode/plotMap2D.m
%  
%%---------------------------------------------------------
% load mask map
function [] = plotMap2D(lon,lat,varInput)
%
% description.
%
% @since 1.0.0
% @param {type} [name] description.
% @return {type} [name] description.
% @see dependencies
%

load('/home/lyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_cp144.mat')% load word land mask
load('/home/lyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/mask/mask_ce72.mat')% load word land mask
load('/home/lyc/lib/tools/matlab/plot/myMap/02.world_map/mat_file/correct_worldmap.mat')
load('/home/lyc/lib/tools/matlab/plot/myMap/01.china_map/mat_file/mask14472.mat')

p_3 = 80;
lon1 = [2.5 357.5]; lat1 = [-p_3 + 1 p_3 - 1]; % world area
set(0, 'defaultfigurecolor', 'w')
set(0, 'DefaultFigureVisible', 'on')

ss = get(0, 'ScreenSize'); % 
h = figure('Position', [ss(4) / 2 ss(3) / 35 ss(3) * 3/9.5 ss(4) * 4/5]); % 
set(h, 'Color', [1 1 1]);

m_proj('Mercator', 'lon', lon1, 'lat', lat1); %Mercator,Equidistant cylindrical,lambert,Miller Cylindrical
m_pcolor(lon, lat, varInput');
colormap(mycolor(18)); %mycolor(100)is soden color colormap(flipud(mycolor(13)));%colormap(jet(4))%
col_SeriesNum=10;
[colorbar_Series] = findSuit_colorInt(varInput, col_SeriesNum);
caxis([min(colorbar_Series) max(colorbar_Series)]);
c = colorbar
c.Ticks=colorbar_Series(2:end-1);
c.Limits = [min(colorbar_Series) max(colorbar_Series)];
c.TickLength = 0.0245;

hold on
m_line(world_mapx(:), world_mapy(:), 'color', [0 0 0], 'LineWidth', 0.5);
m_grid('linestyle', 'none', 'tickdir', 'out', 'yaxislocation', 'left', 'fontsize', 10, 'color', 'k'); 
% C = who('-file','durer.mat');
title(['Varible Name: ',inputname(3)],'Interpreter','latex','fontsize', 16); % cc=',num2str(corr))

end


