function [day]=daycalpro(x)
%��֪���¼���������200510��
%x������day����
month=mod(x,100);
year=(x-month)./100;
num=[1,3,5,7,8,10,12];
if mod(year,4)==0 && mod(year,100) % �ж�year�Ƿ�Ϊ���꣬��Ϊ�����2����29��
    if month==2
        day=29;
    elseif sum(ismember(num,month))==1
        day=31;
    else
        day=30;
    end
else % ����������
    if month==2
        day=28;
    elseif sum(ismember(num,month))==1
        day=31;
    else
        day=30;
    end
end