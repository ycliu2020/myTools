function [ u1,v1,w1 ] = div_from_months( cycle,mm,nn,u,v,w )
%   月资料分解123季度的函数（uvw）
%输入：
% cycle 年份（40）
% mm 第一年初始月
% nn 第一年结束月
% pre,ts 原始数据
%   输出：划分好指定季度的pre和ts变量

int=3;%间隔3个月一季度
u1=single(zeros(144,96,120,2));%40年每个季度发生3*40=120个月
v1=u1;
w1=u1;
for i=1:cycle
    m=(i-1)*12+mm;
    n=(i-1)*12+nn;%元数据
    m1=(i-1)*int+1;
    n1=(i-1)*int+int;%提取后数据
    u1(:,:,m1:n1,:)=u(:,:,m:n,:);
    v1(:,:,m1:n1,:)=v(:,:,m:n,:);
    w1(:,:,m1:n1,:)=w(:,:,m:n,:);    
end

end