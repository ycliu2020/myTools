function [ pre3,ts3 ] = dividedata0( cycle,mm,nn,pre,ts )
%   controlʵ�������Ϸֽ�123���ȵĺ���
%���룺
% cycle ��ݣ�40��
% mm ��һ���ʼ��
% nn ��һ�������
% pre,ts ԭʼ����
%   ��������ֺ�ָ�����ȵ�pre��ts����

int=nn-mm+1; %���ڼ��
pre3=single(zeros(144,96,40*int));
ts3=pre3;
for i=1:cycle
    m=(i-1)*365+mm;
    n=(i-1)*365+nn;%Ԫ����
    m1=(i-1)*int+1;
    n1=(i-1)*int+int;%��ȡ������
    pre3(:,:,m1:n1)=pre(:,:,m:n);
    ts3(:,:,m1:n1)=ts(:,:,m:n);
end

end

