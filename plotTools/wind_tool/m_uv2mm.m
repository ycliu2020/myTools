function [ X,Y,mU,mV ] = m_uv2mm( lon,lat,u,v )
%M_UV2MM is used to convert lon-lat coordinate and u v to X-Y coordinate
%   and corresponding mU mV.

[X,Y]=m_ll2xy(lon,lat,'clip','point');

[XN ,YN ]=m_ll2xy([lon(:) lon(:)]',[lat(:) lat(:)+.001]','clip','off');
[XE ,YE ]=m_ll2xy([lon(:) lon(:)+(.001)./cos(lat(:)*pi/180)]',[lat(:) lat(:)]','clip','off');
mU=u.*reshape(diff(XE),size(lat))*1000 + v.*reshape(diff(XN),size(lat))*1000;
mV=u.*reshape(diff(YE),size(lat))*1000 + v.*reshape(diff(YN),size(lat))*1000;

end