%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-08-09 16:56:54
% LastEditTime : 2020-08-31 22:27:31
% LastEditors  : LYC
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/calNonLocalCld/monthlyToYearlyMean.m
%  
%%---------------------------------------------------------
function yearlyDataMean = monthlyToYearlyMean(monthlyData,lat)
%
% description.
% 转换为年时间序列并做纬向加权平均.

sizeData=size(monthlyData);

if  mod(sizeData(3),12)~=0
    disp('ERROR: Time series is not a multiple of 12!');
    return;
end

% %% method 1: 先求年平均,在进行纬向加权平均
% yearNum=sizeData(3)/12;
% monthlyData=reshape(monthlyData,sizeData(1),sizeData(2),12,yearNum);
% yearlyData=squeeze(nanmean(monthlyData,3));

% % 纬向加权平均
% yearlyDataMean=zeros(yearNum,1);
% for timeNum = 1 : yearNum
%     yearlyDataMean(timeNum)=areaMeanLatWeight(squeeze(yearlyData(:,:,timeNum)), lat);
% end

%% method 2: 先求(月)纬向加权平均, 后求年平均
monNum=sizeData(3);
monthlyDataMean=zeros(monNum,1);
for timeNum = 1 : monNum
    monthlyDataMean(timeNum)=areaMeanLatWeight(squeeze(monthlyData(:,:,timeNum)), lat);
end

yearNum=sizeData(3)/12;
monthlyDataMean=reshape(monthlyDataMean,12,yearNum);
yearlyDataMean=squeeze(nanmean(monthlyDataMean,1));
yearlyDataMean=yearlyDataMean';
end
