function [day]=daycal(x)
%已知月份计算天数
%x月数。day天数
month=mod(x,12);
num=[1,3,5,7,8,10,12];
if month==2
    day=28;
elseif sum(ismember(num,month))==1
    day=31;
else
    day=30;
end

end