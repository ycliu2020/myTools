%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-09 15:50:13
% LastEditTime : 2020-07-28 11:11:30
% LastEditors  : LYC
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/area_mean.m
%  
%%---------------------------------------------------------
function [mean_v] = area_mean(v,latitude)
% function [mean_v] = area_mean(v,latitude)

if ~exist('latitude','var')
  latitude = ones(size(v));
elseif (ndims(v) ~= ndims(latitude)) || any(size(v) ~= size(latitude))
  disp('area_mean: Mismatching dimensions!');
  mean_v = [];
  return;
end

idx = ~isnan(v);
wgt = cos(latitude./180.*pi);
if sum(idx(:)) > 0
  mean_v = sum(v(idx).*wgt(idx)) ./ sum(wgt(idx));
else
  mean_v = NaN;
end

