%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-09 15:50:13
% LastEditors  : Please set LastEditors
% Description  : ��ȡpngͼƬ��ɫ���ĳ���
%                1) ��ͼcolorbar
%                2) ���нű�
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/plotTools/colorbar/getColorbar.m
%
%%---------------------------------------------------------
inputFile = 'ncl_UKM.png';
outputFile = 'newclr';

[colorFinal] = getColorbar1(inputFile, 12);

function [colorFinal] = getColorbar1(inputFile, dividNum)
    %myFun - Description
    % inputFile: input file path

    figCaptrue = imread(inputFile); % eg: �õ���һ��23*189*3�ľ�������23�ǿ��ߣ���189�ǳ���3��RGB��ά��
    % �ж�ͼƬ�ĳ���
    size_figCaptrue = size(figCaptrue);

    if size_figCaptrue(1) > size_figCaptrue(2)
        colorCaptrue = figCaptrue(:, 11, :); %  figCaptrue(11,:,:)�õ��м�һ������ɫ��Ϣ
    elseif size_figCaptrue(1) < size_figCaptrue(2)
        colorCaptrue = figCaptrue(11, :, :); %  figCaptrue(11,:,:)�õ��м�һ������ɫ��Ϣ
    end

    colorFinal = double(reshape(colorCaptrue,length(figCaptrue),3)) / 255;

    %%%�޸��趨Ҫ���ֵ�ɫ�������
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
    colormap(colorFinal)%  ��Ҫת����˫���ȣ�0-1֮�����ֵ
    colorbar
    save outputFile colorFinal -ASCII

end

% ԭ����
% figCaptrue=imread('1.png');  % �õ���һ��23*189*3�ľ�������23�ǿ��ߣ���189�ǳ���3��RGB��ά��
% colorCaptrue=figCaptrue(11,:,:);    %  �õ��м�һ������ɫ��Ϣ
% colorFinal=reshape(colorCaptrue,189,3);   %  ���õ��м�һ��ÿ�����RGB
% colormap(double(colorFinal)/255)    %  ��Ҫת����˫���ȣ�0-1֮�����ֵ
% colorbar
% colorsave=double(colorFinal)/255;
% save colorsave1 colorsave -ASCII
