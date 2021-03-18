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

    widthPlot = 1 ./ ncol .* .7; %��ͼ����
    widthInter = (1 - widthPlot .* ncol) ./ (ncol + 2); % ��ͼ����֮��ļ��
    widthMargin = widthInter .* icol + widthPlot .* (icol - 1) + 0.045; % ��ͼ��߾�

    heightPlot = 1 ./ (nrow + 1) .* 0.8; %��ͼ���
    heightFirstRow = (1 - heightPlot .* nrow) ./ (nrow) + 0.01; % ��һ����ͼ���ϱ߾�(�ű�����ߵ�������ͼ��λ����)
    heightInter = (1 - heightPlot .* nrow) ./ (nrow + 3); % ��ͼ����֮��ļ��
    heightMargin = 1 - heightFirstRow - heightInter .* (irow - 1) - heightPlot .* irow; % ��ͼ�ϱ߾�

    if nrow == 1
        heightMargin = 0.1; heightPlot = 0.8;
        h = subplot('position', [widthMargin heightMargin widthPlot heightPlot]); %[�����Ե ���±�Ե ���� �����]
    elseif ncol == 1
        h = subplot(nrow, ncol, irow);
    else
        h = subplot('position', [widthMargin heightMargin widthPlot heightPlot]); %[�����Ե ���±�Ե ���� �����]
    end

    % h = subplot('position',[widthInter.*icol+widthPlot.*(icol-1) 1-heightPlot.*irow widthPlot heightPlot]);

end

% origial parameters
% widthInter = 0;
% heightPlot = 1 ./ (nrow+1) .* 1.;
% heightPlot = 1 ./ nrow .* .8;

% heightInter = 1-heightPlot.*nrow;
% heightInter = 0;

% xPageMargin=0.045;% x��ҳ�߾�
% xPlotMargin=0.02;% x����ͼ��ļ��
% widthPlot=(1-2*xPageMargin-xPlotMargin.*(ncol-1))/ncol; %��ͼ�Ŀ��
% widthMargin=xPageMargin+(widthPlot+xPlotMargin)*(icol-1);% ��ͼ��߾�

% yPageMargin=0.15;% y��ҳ�߾�
% yPlotMargin=0.02;% y��ҳ�߾�
% heightPlot=(1-yPageMargin-xPageMargin-yPlotMargin.*(nrow-1))/nrow; %��ͼ���
% heightMargin =yPageMargin+(heightPlot+yPlotMargin).*(irow-1); % ��ͼ�ϱ߾�
