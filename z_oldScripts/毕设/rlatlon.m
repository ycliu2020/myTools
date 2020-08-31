function [lon, lat] = rlatlon( ~ )
%加载经纬度的函数（read lat and lon）
%输出经纬度，输入rlatlon直接调用
% datadir1='/data1/cz/gfa1k_all/run_spw_105/atm/hist/run_spw_105.cam.h1.0001-01-01-00000.nc';
datadir1='G:\360data\重要数据\我的文档\MATLAB\paper\data\run_spw_105.cam.h1.0001-01-01-00000.nc';
ncid = netcdf.open(datadir1,'NOWRITE'); %打开nc文件
lon  = ncread(datadir1,'lon'); %读入变量lon
lat  = ncread(datadir1,'lat'); %读入变量lat
netcdf.close(ncid)
end

