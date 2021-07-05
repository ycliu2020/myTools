%%---------------------------------------------------------
% Author       : LYC
% Date         : 2021-06-08 00:10:13
% LastEditTime : 2021-06-08 06:39:57
% LastEditors  : Please set LastEditors
% Description  : maskArea function about including mask coast (only suitalbe for global map)
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/maskArea_coast.m
%
%%---------------------------------------------------------
function maskData = maskArea_coast(maskData, lat, maxlat, minlat, areaNum)

    % method 2
    % right 1
    areaNum=1;
    tmp = maskData(end, :, :);
    maskData(2:end, :, :) = maskData(1:end - 1, :, :);
    maskData(1, :, :) = tmp;
    [maskData, ~, ~] = maskArea(maskData, lat, maxlat, minlat, areaNum);
    % left 1
    tmp = maskData(1, :, :);
    maskData(1:end - 1, :, :) = maskData(2:end, :, :);
    maskData(end, :, :) = tmp;
    [maskData, ~, ~] = maskArea(maskData, lat, maxlat, minlat, areaNum);

    % up 1
    tmp = maskData(:, end, :);
    maskData(:, 2:end, :) = maskData(:, 1:end - 1, :);
    maskData(:, 1, :) = tmp;
    [maskData, ~, ~] = maskArea(maskData, lat, maxlat, minlat, areaNum);

    % down 1
    tmp = maskData(:, 1, :);
    maskData(:, 1:end - 1, :) = maskData(:, 2:end, :);
    maskData(:, end, :) = tmp;
    [maskData, ~, ~] = maskArea(maskData, lat, maxlat, minlat, areaNum);

    % left 1
    tmp = maskData(1, :, :);
    maskData(1:end - 1, :, :) = maskData(2:end, :, :);
    maskData(end, :, :) = tmp;
    [maskData, ~, ~] = maskArea(maskData, lat, maxlat, minlat, areaNum);
    % right 1
    tmp = maskData(end, :, :);
    maskData(2:end, :, :) = maskData(1:end - 1, :, :);
    maskData(1, :, :) = tmp;
    [maskData, ~, ~] = maskArea(maskData, lat, maxlat, minlat, areaNum);

    % down 1
    tmp = maskData(:, 1, :);
    maskData(:, 1:end - 1, :) = maskData(:, 2:end, :);
    maskData(:, end, :) = tmp;
    [maskData, ~, ~] = maskArea(maskData, lat, maxlat, minlat, areaNum);
    % up 1
    tmp = maskData(:, end, :);
    maskData(:, 2:end, :) = maskData(:, 1:end - 1, :);
    maskData(:, 1, :) = tmp;
    [maskData, ~, ~] = maskArea(maskData, lat, maxlat, minlat, areaNum);

end
