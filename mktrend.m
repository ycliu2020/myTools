
function [slope,sign]=mktrend(x,Alpha,n1)
%��ΪMannKendall���Ƽ���ĳ���
% x: �����������Ҫ����仯���Ƶ�ͳ����,ע����һά���飬����Ƕ�άд��ѭ���ͺ��ˣ�����144��98��9����γ�ȡ�ʱ�����У���
%Alpha��������ˮƽ��eg:0.05��������ˮƽ��Ӧ0.95�����Ŷ�
%n:Ҫ����x��ά��
% signΪ�����Խ����1������0����������Ӧ����������ˮƽ��
% slopeб�ʣ�����Theil-Sen��������(ncl����mk��������ϸ�Ľ���)��
% zc: ����ͳ������zc>0��ʾ������zc<0��ʾ�½�������ֵ�ﵽ1.65/1.96/2.58���ֱ��ʾͨ�����Ŷ�90/95/99%�����Լ���

%����S
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

%����vars��zc
vars=len*(len-1)*(2*len+5)/18;
if s>0
    zc=(s-1)/sqrt(vars);
else
    zc=(s+1)/sqrt(vars);
end
%����za����̬�ֲ��ϲ��λ����
za = norminv(1 - Alpha / 2);  %��̬�ֲ�1-a/2�����ķ�λ��,aΪ������ˮƽ

%sign=0;
zc1=abs(zc);
if zc1 >= za
    sign=1;
else
    sign=0;
end


%����б��
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
