function [day]=daycalpro(x)
%已知年月计算天数（200510）
%x月数。day天数
month=mod(x,100);
year=(x-month)./100;
num=[1,3,5,7,8,10,12];
if mod(year,4)==0 && mod(year,100) % 判断year是否为闰年，因为闰年的2月是29天
    if month==2
        day=29;
    elseif sum(ismember(num,month))==1
        day=31;
    else
        day=30;
    end
else % 非闰年的情况
    if month==2
        day=28;
    elseif sum(ismember(num,month))==1
        day=31;
    else
        day=30;
    end
end