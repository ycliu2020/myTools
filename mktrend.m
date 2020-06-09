
function [slope,sign]=mktrend(x,Alpha,n1)
%此为MannKendall趋势检验的程序
% x: 输入变量，需要检验变化趋势的统计量,注意是一维数组，如果是多维写个循环就好了（比如144×98×9（经纬度×时间序列））
%Alpha：显著性水平，eg:0.05的显著性水平对应0.95的置信度
%n:要检验x的维数
% sign为显著性结果，1显著，0不显著（对应上条显著性水平）
% slope斜率（采用Theil-Sen方法计算(ncl官网mk函数有详细的介绍)）
% zc: 检验统计量，zc>0表示上升，zc<0表示下降，绝对值达到1.65/1.96/2.58，分别表示通过置信度90/95/99%显著性检验

%计算S
s=0;
len=size(x,n1);
for m=1:len-1
    for n=m+1:len
        if x(n)>x(m)
            s=s+1;
        elseif x(n)==x(m)
            s=s+0;
        else
            s=s-1;
        end
    end
end

%计算vars和zc
vars=len*(len-1)*(2*len+5)/18;
if s>0
    zc=(s-1)/sqrt(vars);
else
    zc=(s+1)/sqrt(vars);
end
%计算za（正态分布上侧分位数）
za = norminv(1 - Alpha / 2);  %正态分布1-a/2所处的分位数,a为显著性水平

%sign=0;
zc1=abs(zc);
if zc1 >= za
    sign=1;
else
    sign=0;
end


%计算斜率
ndash = len * ( len - 1 ) / 2;
slope1= zeros( ndash, 1 );

m=1;
for k = 1:len-1,
    for j = k+1:len,
        slope1(m) = ( x(j) - x(k) ) / ( j - k ) ;
        m = m + 1;
    end
end
slope= median( slope1 );

end
