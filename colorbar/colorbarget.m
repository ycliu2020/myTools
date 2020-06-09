%此为获取文献中颜色棒的程序
%注意点：每个色标的矩阵大小不一样要根据实际情况修改
%%%修改
a=imread('2.png');  % 举个例子：得到了一个23*189*3的矩阵，其中23是宽（高），189是长，3是RGB的维数
color=a(:,11,:);    %  a(11,:,:)得到中间一条的颜色信息
colorfinal=double(reshape(color,149,3))/255;   %  最后得到中间一条每个点的RGB
%%%end
b=size(colorfinal,1);
%%%修改设定要划分的色棒间隔数
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

colormap(newcolor)    %  需要转化成双精度，0-1之间的数值
colorbar
save colorsave1 newcolor -ASCII

% 原代码
% a=imread('1.png');  % 得到了一个23*189*3的矩阵，其中23是宽（高），189是长，3是RGB的维数
% color=a(11,:,:);    %  得到中间一条的颜色信息
% colorfinal=reshape(color,189,3);   %  最后得到中间一条每个点的RGB
% colormap(double(colorfinal)/255)    %  需要转化成双精度，0-1之间的数值
% colorbar
% colorsave=double(colorfinal)/255;
% save colorsave1 colorsave -ASCII