% function [x, tmp_data] = detrend_lyc(x,t)
% improved by liuyincheng, thanks to xieyan's source code
% attention: this function variety trend only apply xieyan's research, start from march
 function [x, trend1, cons, pvalue] = detrend_yan(x,t)
% x:data need to detrend
% t:time serise
% x:(ntime,1) anomly data
% trend1:(12,2) k and b, from 1-12 month
% cons: (12,1) means of month in 18 years
% pvalue: (12,1) f检验 检验结果

if ~exist('t','var')
  t = 1:length(x);
end

if length(x) ~= length(t)
  disp('ERROR: mismatching x and t!');
  return;
else
  t = reshape(t,size(x));
end

% trend
ntime = length(t);
nyy = ntime/12;
x1 = reshape(x,12,nyy);
t1 = reshape(t,12,nyy);
x1 = x1';
t1 = t1';
% trend = zeros(12,1);
trend = zeros(12,2);
trend1 = zeros(12,2);
pvalue = zeros(12,1);
cons = zeros(12,1);
x0 = ones(nyy,1);
for i = 1:12
%    x1(i,:) = x1(i,:) - mean(x1(i,:)); 
%    tmp_data = polyfit(t1(i,:),x1(i,:),1);
   cons(i,1) = mean(x1(:,i));
   x1(:,i) = x1(:,i) - cons(i,1);%  discrete point minus annual mean
   X = [x0,squeeze(t1(:,i))];
   [b,~,~,~,stats]= regress(x1(:,i),X);
   trend(i,1) = b(2,1);  % k
   trend(i,2) = b(1,1);  % b
   x1(:,i) = x1(:,i) - t1(:,i).*trend(i,1)-trend(i,2);% discrete point minus (kx+b)
   pvalue(i,1) = stats(1,3);
end
x1 = x1';
x = reshape(x1,ntime,1);
trend1(1:2,:) = trend(11:12,:);
trend1(3:12,:) = trend(1:10,:);
