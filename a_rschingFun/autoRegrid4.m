%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-24 14:57:44
% LastEditTime : 2020-07-05 12:36:09
% LastEditors  : LYC
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/autoRegrid4.m
%  
%%---------------------------------------------------------
function data_aft = autoRegrid4( lon_ori, lat_ori, plev_ori, time_ori, data_ori, lon_aft, lat_aft, plev_aft, time_aft)
%
% description.
%
% @since 1.0.0
% @param {type} [name] description.
% @return {type} [name] description.
% @see dependencies
%
[Xlon, Ylat, Zplev, Ttime] = ndgrid(lon_ori, lat_ori, plev_ori, time_ori);
[Xlonf, Ylatf, Zplevf, Ttimef] = ndgrid(lon_aft, lat_aft, plev_aft, time_aft);
data_aft = interpn(Xlon, Ylat, Zplev, Ttime, data_ori, Xlonf, Ylatf, Zplevf, Ttimef);

end
