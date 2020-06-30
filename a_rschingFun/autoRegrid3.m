%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-24 14:57:44
% LastEditTime : 2020-06-24 15:03:07
% LastEditors  : LYC
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/autoRegrid3.m
%  
%%---------------------------------------------------------
function data_aft = autoRegrid3( lat_ori, lon_ori, time_ori, data_ori, lat_aft, lon_aft, time_aft)
%
% description.
%
% @since 1.0.0
% @param {type} [name] description.
% @return {type} [name] description.
% @see dependencies
%
[Xlon, Ylat, Ttime] = meshgrid(lat_ori, lon_ori, time_ori);
[Xlonf, Ylatf, Ttimef] = meshgrid(lat_aft, lon_aft, time_aft);
data_aft = interp3(Xlon, Ylat, Ttime, data_ori, Xlonf, Ylatf, Ttimef);

end
