%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-09 15:50:13
% LastEditTime : 2020-07-29 11:14:21
% LastEditors  : LYC
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/autoCalTrend.m
%  
%%---------------------------------------------------------
function [trendm, trends,trendyr, p, cons] = autoCalTrend(dvar, nlon, nlat, time, startmonth)
    % this program didnt finished  
    %-------------------------------------------------------------------
    % program description
    % auto cal and output the month, season, year trend of data;
    %-------------------------------------------------------------------
    % dvar: vars anomaly, must be 3D dims
    % nlon: length(lon)
    % nlat: length(lat)
    % startmonth: the start month
    %

    %% part1 cal the trend
    trendm = zeros(nlon, nlat, 12, 2); 
    % im==1 is MAM, im==2 is JJA, im==3 is SON, im==4 is DJF
    trends = zeros(nlon, nlat, 4); 
    % trendyr = zeros(nlon, nlat); trendyr_drhs = zeros(nlon, nlat); % trend, yearly
    p = zeros(nlon, nlat, 12); 
    cons = zeros(nlon, nlat, 12); 
    % months mean trend(unite:per day)
    if isnan(dvar(1, 1, 1)) == 1
        for i = 1:nlon
            for j = 2:nlat-1
                [~, trendm(i, j, :, :), cons(i, j, :), p(i, j, :)] = detrend_yc(dvar(i, j, :), time, startmonth);
            end
        end
    else

        for i = 1:nlon
            for j = 1:nlat
                [~, trendm(i, j, :, :), cons(i, j, :), p(i, j, :)] = detrend_yc(dvar(i, j, :), time, startmonth);
            end
        end
    end
    % seasons mean trend (unite:per day)
    for ii = 1:4
     if ii ~= 4
      trends(:,:,ii) = squeeze(mean(trendm(:,:,ii*3:ii*3+2,1),3));
     elseif ii == 4
        ii1=[1,2,12];
        trends(:,:,ii) = squeeze(mean(trendm(:,:,ii1,1),3));
     end
    end
    % years mean trend (unite:per day)
    trendyr = squeeze(mean(trendm(:,:,:,1),3));
