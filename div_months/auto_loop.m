function [ temp2 ] =auto_loop( patch,var,temp0,lev)
%   自动循环
%输入：
% cycle 年份（40）
% mm 第一年初始月
% nn 第一年结束月
% pre,ts 原始数据
%   输出：划分好指定季度的变量

for i=1:2
    datadir=  ['/data1/cz/gfa1k_all/run_spw_',patch{i},'/atm/hist/'];%['F:/paper/data/data/run_spw_',patch{i},'/atm/hist/']; %指定批量数据所在的文件夹
    filelist=dir([datadir,'*h0*.nc']); %指定批量数据的类型且文件名包含h0，此为一个结构体
    for s=1:480
        filename=[datadir,filelist(s+12).name];%因为第一年不算
        ncid=netcdf.open(filename,'NC_NOWRITE');
        temp1= ncread(filename,var);    %变量var（859.535），24层
        temp0(:,:,s,i)=temp1(:,:,lev);netcdf.close(ncid);   % 关闭文件
    end
end

temp2=temp0;
end