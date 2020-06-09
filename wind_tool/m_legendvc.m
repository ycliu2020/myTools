function [ h1,h2,h3 ] = m_legendvc( pos,x,y,u,v,scl,std )
%M_LEGENDVC To add legend for vector.
%   The program is only used for m_map toolbox. This program must use with
%   function m_uv2mm and legend_vc.
%   POS controls the position of legend.
%   The LON,LAT,U,V,SCL must be same as where quiver dose.
%   SCL is the scale of quiver plotted, miss to set as 1.
%   STD to control the standard value for vector legend.
%   h1 for axis;
%   h2 for quiver(line);
%   h3 for text
%
%   AUTHOR sfhstcn2
%   CONTACT sfh_st_cn2@163.com

if any([ndims(x) ndims(y) ndims(u) ndims(v)]>2)
    error('Input arrays has exceeded dimensions');
elseif ~isequal(size(x),size(y),size(u),size(v))
    error('lon,lat,u,v must be same size');
end

[X,Y,mU,mV] = m_uv2mm(x,y,u,v);
rat = max(max(sqrt(u.^2)./sqrt(mU.^2)));
[h1,h2,h3] = legend_vc( pos,X,Y,mU,mV,scl,std/rat );
set(h3,'string',[num2str(std),' m/s']);

end