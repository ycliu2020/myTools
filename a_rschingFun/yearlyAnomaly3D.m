function [ anomaly,var_yr ] = yearlyAnomaly3D(nlongitude,nlatitude,time,var)
    % approved by liuyincheng, this function can diy startmonth now
    % function [ anomaly ] is used to find a monthly anomaly of a given variable
    % startmonth: set the fist month in the data
    % output
    % anomaly
    % var_yr: mean value, sequence: from 1-12
    period = time; % >= datenum(1988,03,01) & time <datenum(2017,03,1); 
    nperiod = length(time);% nperiod = length(time(period));
    [yy,mm,dd] = datevec(time);% [yy,mm,dd] = datevec(time(period));
    var_yr = zeros(nlongitude,nlatitude,12); % monthly averages
    ntime = length(time);
    % var = var(:,:,period);
    for im = 1:nperiod/12

        var_yr(:,:,im) = nanmean(var(:,:,(im-1)*12+1:im*12),3);% this is the average of each month
    end
    var_yr_m=nanmean(var_yr,3);% year mean value 
    for index = 1:nperiod/12
        anomaly(:,:,index) = var_yr(:,:,index)-var_yr_m;
    end

    
    
    