function [move]=running_mean(x,m)
%RUNNING_MEAN  running mean���������ϵĻ���ƽ����
%   x:ʱ�����У�m�����㻬��ƽ������m=3��Ϊ3�㻬��ƽ��
%   move���õ��Ļ���ƽ�����У�����û�м���ֵ��ΪNaN

%Version 1.0
%Copyright by Aires, May, 2013

n=length(x);
move(1:n)=NaN;

for t=1:n-m+1
    move(t+(m-1)/2)=sum(x(t:(t+m-1)))/m;
end

end

