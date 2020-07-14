%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-24 15:15:18
% LastEditTime : 2020-07-03 15:12:44
% LastEditors  : LYC
% Description  : read and Convert netcdf times to datenums(mat date format)
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/cmipTimeRead.m
%  
%%---------------------------------------------------------
function time = cmipTimeRead(filePath,startLoc,count,stride)
% @param [startLoc]  开始时间.
% @param [count] 时间计数.
% @param [stride] 时间步长.
% @return [time] 包含时间的各种信息结构体.
% @see dependencies
%
time.date = ncread(filePath, 'time', startLoc, count, stride); %unite:day
time.date = double(time.date);
time.Units = ncreadatt(filePath, 'time', 'units');
time.Calendar = ncreadatt(filePath, 'time', 'calendar');
time.date = cdfdate2num(time.Units, time.Calendar, time.date);
time.length = length(time.date);

    

end
