function [ u1] = div_from_months_q0( cycle,mm,nn,u)
%   �����Ϸֽ�123���ȵĺ�����uvw��
%���룺
% cycle ��ݣ�40��
% mm ��һ���ʼ��
% nn ��һ�������
% pre,ts ԭʼ����
%   ��������ֺ�ָ�����ȵ�pre��ts����

int=3;%���3����һ����
u1=single(zeros(144,96,120));%40��ÿ�����ȷ���3*40=120����
for i=1:cycle
    m=(i-1)*12+mm;
    n=(i-1)*12+nn;%Ԫ����
    m1=(i-1)*int+1;
    n1=(i-1)*int+int;%��ȡ������
    u1(:,:,m1:n1)=u(:,:,m:n);
end

end