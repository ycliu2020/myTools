%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-11-04 20:51:39
% LastEditTime : 2020-11-05 18:39:17
% LastEditors  : LYC
% Description  : 将matlab计时由s 转化为 h, min, sec
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/tickTok.m
% symbol_custom_string_obkoro1:
%%---------------------------------------------------------

function [] = tickTok(t)
    % myFun - Description
    % input Data: t Unit: s
    % output: t_output = [hour, min, sec]
    %
    if t < 60
        t_sec = t;
        t_sec=roundn(t_sec, -2);
        disp([num2str(t_sec), 's'])
    elseif t >= 60 && t <= 60 * 60
        t_min = fix(t / 60);
        t_sec = t - t_min * 60;
        t_sec=roundn(t_sec, -2);
        disp([num2str(t_min), 'm:', num2str(t_sec), 's'])
    else
        t_hour = fix(t / 60/60);
        t_min = fix((t - t_hour * 60 * 60) / 60);
        t_sec = t - t_hour * 60 * 60 - t_min * 60;
        t_sec=roundn(t_sec, -2);
        disp([num2str(t_hour), 'h:', num2str(t_min), 'm:', num2str(t_sec), 's'])
    end

end
