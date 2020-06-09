% function [x, tmp_data] = detrend_lyc(x,t)
% improved by liuyincheng, thanks to xieyan's source code
% attention: this function caled variety trend from 1-12 month
function [x, trend, cons, pvalue] = detrendyr_yc(x,t)
    % x:data need to detrend
    % t:time serise
    % x:(ntime,1) anomaly data
    % startmonth: the start month
    % mon2: the end month
    % trend1:(12,2) k and b,start from 1-12 month
    % cons: (12,1) means of month in 18 years
    % pvalue: (12,1) f检验 检验结果
    
    if ~exist('t','var')
      t = 1:length(x);
    end
    
    % if length(x) ~= length(t)
    %   disp('ERROR: mismatching x and t!');
    %   return;
    % else
    %   t = reshape(t,size(x));
    % end
    t = reshape(t,size(x));
    % trend
    nyy = length(t);
    x1 = reshape(x,1,nyy);
    t1 = reshape(t,1,nyy);
    x1 = x1';%nyy*1
    t1 = t1';%nyy*1
    % trend = zeros(12,1);
    trend = zeros(1,2);
    trend1 = zeros(1,2);
    pvalue = zeros(1,1);
    cons = zeros(1,1);
    x0 = ones(nyy,1);
 
  
    cons(1,1) = mean(x1(:,1));
    x1(:,1) = x1(:,1) - cons(1,1);%  discrete point minus annual mean
    X = [x0,squeeze(t1(:,1))];
    [b,~,~,~,stats]= regress(x1(:,1),X);
    trend(1,1) = b(2,1);  % k
    trend(1,2) = b(1,1);  % b
    x1(:,1) = x1(:,1) - t1(:,1).*trend(1,1)-trend(1,2);% discrete point minus (kx+b)
    pvalue(1,1) = stats(1,3);

    x = x1';
    
