function [lon, lat] = rlatlon( ~ )
%���ؾ�γ�ȵĺ�����read lat and lon��
%�����γ�ȣ�����rlatlonֱ�ӵ���
% datadir1='/data1/cz/gfa1k_all/run_spw_105/atm/hist/run_spw_105.cam.h1.0001-01-01-00000.nc';
datadir1='G:\360data\��Ҫ����\�ҵ��ĵ�\MATLAB\paper\data\run_spw_105.cam.h1.0001-01-01-00000.nc';
ncid = netcdf.open(datadir1,'NOWRITE'); %��nc�ļ�
lon  = ncread(datadir1,'lon'); %�������lon
lat  = ncread(datadir1,'lat'); %�������lat
netcdf.close(ncid)
end

