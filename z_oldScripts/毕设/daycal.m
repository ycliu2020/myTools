function [day]=daycal(x)
%��֪�·ݼ�������
%x������day����
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