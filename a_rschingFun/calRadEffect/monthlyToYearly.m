%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-08-31 21:14:59
% LastEditTime : 2020-08-31 22:33:30
% LastEditors  : LYC
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/calRadEffect/monthlyToYearly.m
%  
%%---------------------------------------------------------
function yearlyData = monthlyToYearly(monthlyData)
    %
    % description.
    monthlyData=squeeze(monthlyData);
    
    sizeData=size(monthlyData);
    
    if  mod(sizeData(3),12)~=0
        disp('ERROR: Time series is not a multiple of 12!');
        return;
    end
    
    %% method 1: 先求年平均,在进行纬向加权平均
    yearNum=sizeData(3)/12;
    monthlyData=reshape(monthlyData,sizeData(1),sizeData(2),12,yearNum);
    yearlyData=squeeze(nanmean(monthlyData,3));
    

    

end