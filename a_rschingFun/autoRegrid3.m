%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-24 14:57:44
% LastEditTime : 2020-07-12 19:01:07
% LastEditors  : LYC
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/autoRegrid3.m
%  
%%---------------------------------------------------------
function data_aft= autoRegrid3( lon_ori, lat_ori, time_ori, data_ori, lon_aft, lat_aft, time_aft)
%
% description.
%
% @since 1.0.0
% @param {type} [name] description.
% @return {type} [name] description.
% @see dependencies
%
data_ori=squeeze(data_ori);
[Xlon, Ylat, Ttime] = ndgrid(lon_ori, lat_ori, time_ori);
[Xlonf, Ylatf, Ttimef] = ndgrid(lon_aft, lat_aft, time_aft);
data_aft = interpn(Xlon, Ylat, Ttime, data_ori, Xlonf, Ylatf, Ttimef);
end
