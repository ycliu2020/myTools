function [ anomaly,var_m ] = monthlyAnomaly3D(nlongitude,nlatitude,time,var,startmonth)
% approved by liuyincheng, this function can diy startmonth now
% function [ anomaly ] is used to find a monthly anomaly of a given variable
% startmonth: set the fist month in the data
% output
% anomaly
% var_m: mean value, sequence: from 1-12
period = time; % >= datenum(1988,03,01) & time <datenum(2017,03,1); 
nperiod = length(time);% nperiod = length(time(period));
[yy,mm,dd] = datevec(time);% [yy,mm,dd] = datevec(time(period));
var_m = zeros(nlongitude,nlatitude,12); % monthly averages
ntime = length(time);
% var = var(:,:,period);
for im = 1:12
    index_mm = mm == im;
    var_m(:,:,im) = nanmean(var(:,:,index_mm),3);% this is the average of each month
end
anomaly = zeros(nlongitude,nlatitude,nperiod);
pnum=startmonth-2;
for ii = 1:nperiod
    anomaly(:,:,ii) = var(:,:,ii) - var_m(:,:,mod(ii+pnum,12)+1); % 
end


