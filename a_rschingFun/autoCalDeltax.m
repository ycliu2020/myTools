%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-09-02 09:53:35
% LastEditTime : 2020-09-04 10:50:25
% LastEditors  : LYC
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/autoCalDeltax.m
%  
%%---------------------------------------------------------
function deltaData = autoCalDeltax(dataInput, time)
    %
    % description.
    % dataInput: 1维时间序列
    % deltaData: 这段时间内数据的变化量
    %
    k_data = polyfit(time', dataInput, 1);
    deltaData= k_data(1) * (time(end)-time(1));
end
    