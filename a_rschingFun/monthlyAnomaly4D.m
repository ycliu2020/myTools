function [anomaly,var_m ] = monthlyAnomaly4D(nlongitude,nlatitude,nplev,time,var,startmonth)
% approved by liuyincheng, this function can diy startmonth now
% function [ anomaly ] is used to find a monthly anomaly of a given variable
% output
% anomaly
% var_m: mean value, sequence: from 1-12

period = time;%>= datenum(1988,03,01) & time < datenum(2017,02,29); 
nperiod = length(time);%nperiod = length(time(period));
[yy, mm, dd] = datevec(time);
ntime = length(time);
% var = var(:,:,:,period);
var_m = zeros(nlongitude,nlatitude,nplev,12); %monthly averages
for im = 1:12
    index_mm = mm == im;
    var_m(:,:,:,im) = nanmean(var(:,:,:,index_mm),4);%this is the average of each month
end
anomaly = zeros(nlongitude,nlatitude,nplev,nperiod);
pnum=startmonth-2;
for ii = 1:nperiod
    anomaly(:,:,:,ii) = var(:,:,:,ii) - var_m(:,:,:,mod(ii+pnum,12)+1);
end
