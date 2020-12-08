%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-09 15:50:13
% LastEditors  : Please set LastEditors
% Description  : 获取png图片颜色棒的程序
%                1) 截图colorbar
%                2) 运行脚本
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/plotTools/colorbar/getColorbar.m
%
%%---------------------------------------------------------
inputFile = 'ncl_UKM.png';
outputFile = 'newclr';

[colorFinal] = getColorbar1(inputFile, 12);

function [colorFinal] = getColorbar1(inputFile, dividNum)
    %myFun - Description
    % inputFile: input file path

    figCaptrue = imread(inputFile); % eg: 得到了一个23*189*3的矩阵，其中23是宽（高），189是长，3是RGB的维数
    % 判断图片的长宽
    size_figCaptrue = size(figCaptrue);

    if size_figCaptrue(1) > size_figCaptrue(2)
        colorCaptrue = figCaptrue(:, 11, :); %  figCaptrue(11,:,:)得到中间一条的颜色信息
    elseif size_figCaptrue(1) < size_figCaptrue(2)
        colorCaptrue = figCaptrue(11, :, :); %  figCaptrue(11,:,:)得到中间一条的颜色信息
    end

    colorFinal = double(reshape(colorCaptrue,length(figCaptrue),3)) / 255;

    %%%修改设定要划分的色棒间隔数
    num = dividNum;
    %%%end
    num1 = fix((length(figCaptrue) / (num - 1)));
    newcolor = zeros(num, 3);

    for i = 1:num
        countNum = 1 + (i - 1) * num1;

        for j = 1:3
            newcolor(i, j) = colorFinal(countNum, j);
        end

    end

    colorFinal = newcolor;

    colorFinal = double(colorFinal);
    colormap(colorFinal)%  需要转化成双精度，0-1之间的数值
    colorbar
    save outputFile colorFinal -ASCII

end

% 原代码
% figCaptrue=imread('1.png');  % 得到了一个23*189*3的矩阵，其中23是宽（高），189是长，3是RGB的维数
% colorCaptrue=figCaptrue(11,:,:);    %  得到中间一条的颜色信息
% colorFinal=reshape(colorCaptrue,189,3);   %  最后得到中间一条每个点的RGB
% colormap(double(colorFinal)/255)    %  需要转化成双精度，0-1之间的数值
% colorbar
% colorsave=double(colorFinal)/255;
% save colorsave1 colorsave -ASCII
