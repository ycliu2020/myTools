%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-15 20:39:19
% LastEditTime : 2020-06-16 10:37:49
% LastEditors  : LYC
% Description  : given that we have a series, now need to plot
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/colorbar/findSuit_colorInt.m
%  
%%---------------------------------------------------------
function [colorbar_Series] = findSuit_colorInt(data, col_SeriesNum)
    % colorbar_Series: like c=colorbar; c.Ticks = [-4, -3, -2, -1, 0, 1, 2, 3, 4]; c.Limits = [mmin mmax];
    % data: input data
    % col_SeriesNum: assign the amount of colors, must be even number
    data(isnan(data))=[];
    temp=sort(data(:));
    tempPlus=temp(temp>=0);
    tempMinus=temp(temp<0);
    if abs(mean(tempMinus))>=abs(mean(tempPlus))||isempty(tempPlus)==1
        temp1=abs(mean(tempMinus));
    else
        temp1=abs(mean(tempPlus));
    end
    %整数位数
    result = log10(temp1);
    result = floor(result)+1;
    if result>=2
        mid_cols= round(temp1);
    else 
        mid_cols= round(temp1*10^(2-result))/(10^(2-result));
    end

    max_colS=mid_cols*2;
    colorbar_Series=linspace(-max_colS,max_colS,col_SeriesNum+1);
    
    cS_Plus=colorbar_Series(colorbar_Series>1e-10);
    result1 = log10(cS_Plus);
    result1 = floor(result1)+1;
    if result1>=2
        cS_Plus= round(cS_Plus);
    else 
        cS_Plus= round(cS_Plus.*10.^(2-result1))./(10.^(2-result1));
    end
    colorbar_Series(1,col_SeriesNum/2+2:end)=cS_Plus;
    colorbar_Series(1,1:col_SeriesNum/2)=fliplr(-cS_Plus);
end
