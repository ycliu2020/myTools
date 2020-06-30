%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-24 14:57:44
% LastEditTime : 2020-06-24 15:42:27
% LastEditors  : LYC
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/autoRegrid4.m
%  
%%---------------------------------------------------------
function data_aft = autoRegrid4( lat_ori, lon_ori, plev_ori, time_ori, data_ori, lat_aft, lon_aft, plev_aft, time_aft)
%
% description.
%
% @since 1.0.0
% @param {type} [name] description.
% @return {type} [name] description.
% @see dependencies
%
[Xlon, Ylat, Zplev, Ttime] = ndgrid(lat_ori, lon_ori, plev_ori, time_ori);
[Xlonf, Ylatf, Zplevf, Ttimef] = ndgrid(lat_aft, lon_aft, plev_aft, time_aft);
data_aft = interpn(Xlon, Ylat, Zplev, Ttime, data_ori, Xlonf, Ylatf, Zplevf, Ttimef);

end
