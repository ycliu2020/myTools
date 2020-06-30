%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-24 10:57:57
% LastEditTime : 2020-06-24 15:34:18
% LastEditors  : LYC
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/getPath_fileName.m
%  
%%---------------------------------------------------------
function filePath = getPath_fileName(inputPath,parameter)
%
% description.
% aim to get path
% parameter : same as the use of dir, '.' mean file and folder
% @param {type} [name] description.
% @return {type} [name] description.
% @see dependencies
%
% inputPath='/data1/liuyincheng/CMIP6-mirror/amip/CMIP/ACCESS-CM2';
file = dir(fullfile(inputPath,parameter));
for i=3:length(file)
    filePath{i-2,1}=file(i,1).name;
end
    
end

