%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-08-27 10:18:33
% LastEditTime : 2020-08-27 10:22:28
% LastEditors  : LYC
% Description  : 过定点拟合(截距为0)
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/calNonLocalCld/plotLinFit_point0.m
%  
%%---------------------------------------------------------
function [k, b] = plotLinFit_point0(xdata, ydata, xLabel, yLabel, modelName)
    % ydata=kx+b; known xdata and ydata series
    % 1) cal k and b
    % 2) plot fit fig
    % switch nargin
    % case 'string'
        
    fun = @(x,xdata)x(1)*xdata;
    b0 = [0,0];
    [kb,~,r,~,~] = lsqcurvefit(fun,b0,xdata,ydata);

    k = kb(1);
    b = kb(2);
    yfit = polyval(kb, xdata);

    figure;
    plot(xdata, ydata, 'o', xdata, yfit, '-')
    xlabel(xLabel)
    ylabel(yLabel)
    title({['ssp370 Model: ', modelName]; ['斜率: ', num2str(k), '截距: ', num2str(b)]})
    
    % 计算r2并标注
    yresid = ydata - yfit; %将残差值计算为有符号数的向量：
    SSresid = sum(yresid.^2); %计算残差的平方并相加，以获得残差平方和：
    SStotal = (length(ydata) - 1) * var(ydata); %通过将观测次数减 1(自由度) 再乘以 ydata 的方差，计算 ydata 的总平方和：
    rsq = 1 - SSresid / SStotal; %计算r2
    text(0.4, 0.8, ['r2= ', num2str(rsq)], 'units', 'normalized');
    hold on
    legend('data', 'linear fit','Location','north')

    figName=['/home/liuyc/Research/P02.Ts_change_research/figure/02.cmip6Result/1.6/nonLocalCld2_fix/Cktest/ssp370_r1i1p1f1_',modelName,'.png'];
    % saveas(gcf, figName)
    % % % close gcf

end