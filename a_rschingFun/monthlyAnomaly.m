%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-09 15:50:13
% LastEditTime : 2020-07-29 10:44:53
% LastEditors  : LYC
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/monthlyAnomaly.m
%  
%%---------------------------------------------------------
function [ anomaly,var_m ] = monthlyAnomaly(nlongitude,nlatitude,nplev,time,var,startmonth)
    % approved by liuyincheng, this function can diy startmonth now
    % 3D and 4D vars are considered.
    % function [ anomaly ] is used to find a monthly anomaly of a given variable
    % startmonth: set the fist month in the data
    % output
    % anomaly
    % var_m: mean value, sequence: from 1-12
    
    if length(size(var))==3 % 3D vars (lon,lat,time)
        period = time; % >= datenum(1988,03,01) & time <datenum(2017,03,1); 
        nperiod = length(time);% nperiod = length(time(period));
        [yy,mm,dd] = datevec(time);% [yy,mm,dd] = datevec(time(period));
        var_m = zeros(nlongitude,nlatitude,12); % monthly averages
        ntime = length(time);
        % var = var(:,:,period);
        for monthNum = 1:12
            month_index = mm == monthNum;
            var_m(:,:,monthNum) = nanmean(var(:,:,month_index),3);% this is the average of each month
        end
        anomaly = zeros(nlongitude,nlatitude,nperiod);
        pnum=startmonth-2;
        for ii = 1:nperiod
            anomaly(:,:,ii) = var(:,:,ii) - var_m(:,:,mod(ii+pnum,12)+1); % 
        end
    elseif length(size(var))==4 % 4D vars (lon,lat,plev,time)
        period = time;%>= datenum(1988,03,01) & time < datenum(2017,02,29); 
        nperiod = length(time);%nperiod = length(time(period));
        [yy, mm, dd] = datevec(time);
        ntime = length(time);
        % var = var(:,:,:,period);
        var_m = zeros(nlongitude,nlatitude,nplev,12); %monthly averages
        for monthNum = 1:12
            month_index = mm == monthNum;
            var_m(:,:,:,monthNum) = nanmean(var(:,:,:,month_index),4);%this is the average of each month
        end
        anomaly = zeros(nlongitude,nlatitude,nplev,nperiod);
        pnum=startmonth-2;
        for ii = 1:nperiod
            anomaly(:,:,:,ii) = var(:,:,:,ii) - var_m(:,:,:,mod(ii+pnum,12)+1);
        end

    elseif length(size(var))==2 % 1D vars (time,1)

        period = time; % >= datenum(1988,03,01) & time <datenum(2017,03,1); 
        nperiod = length(time);% nperiod = length(time(period));
        [yy,mm,dd] = datevec(time);% [yy,mm,dd] = datevec(time(period));
        var_m = zeros(12,1); % monthly averages
        ntime = length(time);
        % var = var(:,:,period);
        for monthNum = 1:12
            month_index = mm == monthNum;
            var_m(monthNum) = nanmean(var(month_index));% this is the average of each month
        end
        anomaly = zeros(nperiod,1);
        pnum=startmonth-2;
        for ii = 1:nperiod
            anomaly(ii) = var(ii) - var_m(mod(ii+pnum,12)+1); % 
        end

    end

end
        