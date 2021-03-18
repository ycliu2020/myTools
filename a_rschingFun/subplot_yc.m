%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-09 15:50:13
% LastEditTime : 2021-02-09 01:04:09
% LastEditors  : LYC
% Description  : flexible plot sub figures
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/subplot_yc.m
%
%%---------------------------------------------------------
function [h] = subplot_yc(nrow, ncol, irow, icol)
    %
    % function [h] = subplot_yih(nrow,ncol,irow,icol)
    %

    widthPlot = 1 ./ ncol .* .7; %子图长度
    widthInter = (1 - widthPlot .* ncol) ./ (ncol + 2); % 子图左右之间的间距
    widthMargin = widthInter .* icol + widthPlot .* (icol - 1) + 0.045; % 子图左边距

    heightPlot = 1 ./ (nrow + 1) .* 0.8; %子图宽度
    heightFirstRow = (1 - heightPlot .* nrow) ./ (nrow) + 0.01; % 第一行子图的上边距(放标题或者调整整幅图的位置用)
    heightInter = (1 - heightPlot .* nrow) ./ (nrow + 3); % 子图上下之间的间距
    heightMargin = 1 - heightFirstRow - heightInter .* (irow - 1) - heightPlot .* irow; % 子图上边距

    if nrow == 1
        heightMargin = 0.1; heightPlot = 0.8;
        h = subplot('position', [widthMargin heightMargin widthPlot heightPlot]); %[离左边缘 离下边缘 自身长 自身宽]
    elseif ncol == 1
        h = subplot(nrow, ncol, irow);
    else
        h = subplot('position', [widthMargin heightMargin widthPlot heightPlot]); %[离左边缘 离下边缘 自身长 自身宽]
    end

    % h = subplot('position',[widthInter.*icol+widthPlot.*(icol-1) 1-heightPlot.*irow widthPlot heightPlot]);

end

% origial parameters
% widthInter = 0;
% heightPlot = 1 ./ (nrow+1) .* 1.;
% heightPlot = 1 ./ nrow .* .8;

% heightInter = 1-heightPlot.*nrow;
% heightInter = 0;

% xPageMargin=0.045;% x轴页边距
% xPlotMargin=0.02;% x轴子图间的间距
% widthPlot=(1-2*xPageMargin-xPlotMargin.*(ncol-1))/ncol; %子图的宽度
% widthMargin=xPageMargin+(widthPlot+xPlotMargin)*(icol-1);% 子图左边距

% yPageMargin=0.15;% y轴页边距
% yPlotMargin=0.02;% y轴页边距
% heightPlot=(1-yPageMargin-xPageMargin-yPlotMargin.*(nrow-1))/nrow; %子图宽度
% heightMargin =yPageMargin+(heightPlot+yPlotMargin).*(irow-1); % 子图上边距
