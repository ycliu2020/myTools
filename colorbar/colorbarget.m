%��Ϊ��ȡ��������ɫ���ĳ���
%ע��㣺ÿ��ɫ��ľ����С��һ��Ҫ����ʵ������޸�
%%%�޸�
a=imread('2.png');  % �ٸ����ӣ��õ���һ��23*189*3�ľ�������23�ǿ��ߣ���189�ǳ���3��RGB��ά��
color=a(:,11,:);    %  a(11,:,:)�õ��м�һ������ɫ��Ϣ
colorfinal=double(reshape(color,149,3))/255;   %  ���õ��м�һ��ÿ�����RGB
%%%end
b=size(colorfinal,1);
%%%�޸��趨Ҫ���ֵ�ɫ�������
num=14;
%%%end
num1=fix((b/(num-1)));
c=1;
 newcolor=zeros(num,3);
for i=1:num
    c=1+(i-1)*num1;
    for j=1:3
newcolor(i,j)=colorfinal(c,j);
    end
end

colormap(newcolor)    %  ��Ҫת����˫���ȣ�0-1֮�����ֵ
colorbar
save colorsave1 newcolor -ASCII

% ԭ����
% a=imread('1.png');  % �õ���һ��23*189*3�ľ�������23�ǿ��ߣ���189�ǳ���3��RGB��ά��
% color=a(11,:,:);    %  �õ��м�һ������ɫ��Ϣ
% colorfinal=reshape(color,189,3);   %  ���õ��м�һ��ÿ�����RGB
% colormap(double(colorfinal)/255)    %  ��Ҫת����˫���ȣ�0-1֮�����ֵ
% colorbar
% colorsave=double(colorfinal)/255;
% save colorsave1 colorsave -ASCII