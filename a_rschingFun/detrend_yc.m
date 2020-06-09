% improved by liuyincheng, thanks to xieyan's source code
% attention: this function caled variety trendMon from 1-12 month
function [varb_detrend, trendMon_startJan, cons, pvalue] = detrend_yc(varb,time,startmonth)
% varb:data need to detrend
% time:time serise
% varb:(ntime,1) anomaly data
% startmonth: the start month
% mon2: the end month
% trendMon_startJan:(12,2) k and b,start from 1-12 month
% cons: (12,1) means of month in 18 years
% pvalue: (12,1) f检验 检验结果

if ~exist('time','var')
  time = 1:length(varb);
end

varbLen=size(varb);
if varbLen(3) ~= length(time)
  disp('ERROR: mismatching varb and time!');
  return;
else
  time = reshape(time,size(varb));
end

ntime = length(time);
nyy = ntime/12;
varbShape = reshape(varb,12,nyy);
timeShape = reshape(time,12,nyy);
varbShape = varbShape';% nyy*12
timeShape = timeShape';% nyy*12
% trendMon = zeros(12,1);
trendMon = zeros(12,2);
trendMon_startJan = zeros(12,2);
pvalue = zeros(12,1);
cons = zeros(12,1);
x0 = ones(nyy,1);
for i = 1:12
   cons(i,1) = mean(varbShape(:,i));
   varbShape(:,i) = varbShape(:,i) - cons(i,1);%  discrete point minus annual mean
   X = [x0,squeeze(timeShape(:,i))];
   [b,~,r,~,stats]= regress(varbShape(:,i),X);
   trendMon(i,1) = b(2,1);  % k
   trendMon(i,2) = b(1,1);  % b
   varb_detrend(:,i)=r;% detrend after dvars : discrete point minus (kx+b)
  %  varbShape(:,i) = varbShape(:,i) - timeShape(:,i).*trendMon(i,1)-trendMon(i,2);% detrend after dvars : discrete point minus (kx+b)
   pvalue(i,1) = stats(1,3);
end
varb_detrend=varb_detrend';
varb_detrend=reshape(varb_detrend,ntime,1);
% varbShape = varbShape';
% varb = reshape(varbShape,ntime,1);

% transform trendMon start from 1-12 (trendMon(startmonth:...) trendMon_startJan(1:12))
mon2=startmonth-1;
if startmonth == 1
    trendMon_startJan = trendMon;
else
    trendMon_startJan(1:startmonth - 1, :) = trendMon(13 - mon2:12, :);
    trendMon_startJan(startmonth:12, :) = trendMon(1:12 - mon2, :);
end
