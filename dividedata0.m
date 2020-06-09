function [ pre3,ts3 ] = dividedata0( cycle,mm,nn,pre,ts )
%   control实验年资料分解123季度的函数
%输入：
% cycle 年份（40）
% mm 第一年初始天
% nn 第一年结束天
% pre,ts 原始数据
%   输出：划分好指定季度的pre和ts变量

int=nn-mm+1; %季节间隔
pre3=single(zeros(144,96,40*int));
ts3=pre3;
for i=1:cycle
    m=(i-1)*365+mm;
    n=(i-1)*365+nn;%元数据
    m1=(i-1)*int+1;
    n1=(i-1)*int+int;%提取后数据
    pre3(:,:,m1:n1)=pre(:,:,m:n);
    ts3(:,:,m1:n1)=ts(:,:,m:n);
end

end

