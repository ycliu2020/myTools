function [varb_detrend, trendyr, trendm, trends, cons_m, pvalue_m] = detrend_lyc(varb,lat,lon,time,startmonth)
   
% 未完成 原计划用查询的方法得到精确的月份, 暂且搁置  
    %DETREND_LYC Summary of this function goes here
%   trendm: start from 1-12 month 

period = time; % >= datenum(1988,03,01) & time <datenum(2017,03,1);
nperiod = length(time); % nperiod = length(time(period));
nlat=length(lat);
nlon=length(lon);
[yy, mm, dd] = datevec(time); % precise query
var_m = zeros(nlon, nlat, 12); % monthly averages
ntime = length(time);



% var = var(:,:,period);
for monthNum = 1:12
    month_index = mm == monthNum;
    var_m(:, :, monthNum) = nanmean(varb(:, :, month_index), 3); % this is the average of each month
    var_dividMon(:,:,:,monthNum)=varb(:, :, month_index);
    time_dividMon(:,monthNum)=time(month_index);
end

trendm=zeros(nlon,nlat,12);
trends=zeros(nlon,nlat,4);
trendyr=zeros(nlon,nlat);

trendMon = zeros(12, 2);
trendMon_startJan = zeros(12, 2);
pvalue = zeros(12, 1);
cons = zeros(12, 1);
x0 = ones(nyy, 1);

for i = 1:nlon
    for j = 1:nlat
        for monthNum = 1:12
            onePit_detrend=squeeze(squeeze(var_dividMon(i,j,:,:)));
            cons1(monthNum, 1) = mean(onePit_detrend(:, monthNum));
            onePit_detrend(:, monthNum) = onePit_detrend(:, monthNum) - cons1(monthNum, 1); %  discrete point minus annual mean
            X = [x0, squeeze(time_dividMon(:, monthNum))];
            [b, ~, r, ~, stats] = regress(onePit_detrend(:, monthNum), X);
            trendMon1(monthNum, 1) = b(2, 1); % k
            trendMon1(monthNum, 2) = b(1, 1); % b
            onePit_detrend(:, monthNum) = onePit_detrend(:, monthNum) - time_dividMon(:, monthNum) .* trendMon1(monthNum, 1) - trendMon1(monthNum, 2); % detrend after dvars : discrete point minus (kx+b)
            varbShapecopy1(:, monthNum) = r; %
            pvalue(monthNum, 1) = stats(1, 3);
        end 
        trendm(i,j,:)= trendMon1(:, 1);
        varb_detrend(i,j,:)=onePit_detrend=
    end
end



end

