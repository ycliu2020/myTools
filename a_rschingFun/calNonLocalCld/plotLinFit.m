%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-08-14 09:56:59
% LastEditTime : 2020-08-14 16:39:17
% LastEditors  : LYC
% Description  :
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/calNonLocalCld/plotLinFit.m
%
%%---------------------------------------------------------
function [k, b] = plotLinFit(x, y, xLabel, yLabel, modelName, figName)
    % y=kx+b; known x and y series
    % 1) cal k and b
    % 2) plot fit fig
    % switch nargin
    % case 'string'
        
    % end
    kb = polyfit(x, y, 1);
    k = kb(1);
    b = kb(2);
    yfit = polyval(kb, x);

    figure;
    plot(x, y, 'o', x, yfit, '-')
    xlabel(xLabel)
    ylabel(yLabel)
    title({['ssp370 Model: ', modelName]; ['斜率: ', num2str(k), '截距: ', num2str(b)]})
    
    % 计算r2并标注
    yresid = y - yfit; %将残差值计算为有符号数的向量：
    SSresid = sum(yresid.^2); %计算残差的平方并相加，以获得残差平方和：
    SStotal = (length(y) - 1) * var(y); %通过将观测次数减 1(自由度) 再乘以 y 的方差，计算 y 的总平方和：
    rsq = 1 - SSresid / SStotal; %计算r2
    text(0.75, 0.8, ['r2= ', num2str(rsq)], 'units', 'normalized');
    hold on
    legend('data', 'linear fit')

    figName=['/home/liuyc/Research/P02.Ts_change_research/figure/02.cmip6Result/1.6/nonLocalCld2_fix/Cktest/ssp370_r1i1p1f1_',modelName,'.png'];
    % saveas(gcf, figName)
    % % % close gcf

end
