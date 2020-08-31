function [move]=running_mean(x,m)
%RUNNING_MEAN  running mean，气象资料的滑动平均法
%   x:时间序列，m：几点滑动平均，如m=3，为3点滑动平均
%   move：得到的滑动平均序列，两端没有计算值的为NaN

%Version 1.0
%Copyright by Aires, May, 2013

n=length(x);
move(1:n)=NaN;

for t=1:n-m+1
    move(t+(m-1)/2)=sum(x(t:(t+m-1)))/m;
end

end

