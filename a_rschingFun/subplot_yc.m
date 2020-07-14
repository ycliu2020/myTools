%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-09 15:50:13
% LastEditTime : 2020-07-07 11:01:25
% LastEditors  : LYC
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/subplot_yc.m
%  
%%---------------------------------------------------------
function [h] = subplot_yc(nrow,ncol,irow,icol)
%
% function [h] = subplot_yih(nrow,ncol,irow,icol)
%
if nrow==1&&ncol==1
    h = subplot('position',[0.1 0.1 0.8 0.8]);%[�����Ե ���±�Ե ����� �����]
else

    widthPlot = 1 ./ ncol .* .7;%��ͼ���
    widthInter = (1 - widthPlot .* ncol) ./ (ncol+2);% ��ͼ�����Ҽ��
    widthMargin=widthInter.*icol+widthPlot.*(icol-1)+0.045;% ��ͼ��߾�


    heightPlot = 1 ./ (nrow+1) .* 0.8;%��ͼ�߶�
    firstheight= (1 - heightPlot .* nrow) ./ (nrow)+0.01;% ��ͼ��һ�е��ϱ߾�(�ű�����ߵ�������ͼ��λ����)
    heightinter = (1 - heightPlot .* nrow) ./ (nrow+3);% ��ͼ�߶ȼ��
    heightMargin =1-firstheight-heightinter.*(irow-1)-heightPlot.*irow; % ��ͼ�ϱ߾�
    
    
    % h = subplot('position',[widthInter.*icol+widthPlot.*(icol-1) 1-heightPlot.*irow widthPlot heightPlot]);
    h = subplot('position',[widthMargin heightMargin widthPlot heightPlot]);    
end

    % origial parameters
    % widthInter = 0;
    % heightPlot = 1 ./ (nrow+1) .* 1.;
    % heightPlot = 1 ./ nrow .* .8;

    % heightinter = 1-heightPlot.*nrow;
    % heightinter = 0;

    % xPageMargin=0.045;% x��ҳ�߾�
    % xPlotMargin=0.02;% x����ͼ��ļ��
    % widthPlot=(1-2*xPageMargin-xPlotMargin.*(ncol-1))/ncol; %��ͼ�Ŀ��
    % widthMargin=xPageMargin+(widthPlot+xPlotMargin)*(icol-1);% ��ͼ��߾�

    % yPageMargin=0.15;% y��ҳ�߾�
    % yPlotMargin=0.02;% y��ҳ�߾�
    % heightPlot=(1-yPageMargin-xPageMargin-yPlotMargin.*(nrow-1))/nrow; %��ͼ�߶�
    % heightMargin =yPageMargin+(heightPlot+yPlotMargin).*(irow-1); % ��ͼ�ϱ߾�