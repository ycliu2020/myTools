function [] = auto_map(  )
%draw outline
%   此处显示详细说明
dir='G:\360data\重要数据\我的文档\MATLAB\paper\datawork\画图\中国地图\mapdata';%地图数据目录
ma=shaperead([dir,'\中国边界数据\国界线\bou1_4p.shp']);mb=shaperead([dir,'\青藏高原\DBATP_Polygon.shp']);
max=[ma(:).X];may= [ma(:).Y];m_line(max,may,'color',[0 0 0],'LineWidth',0.5);hold on;mbx=[mb(:).X];mby= [mb(:).Y];m_line(mbx,mby,'color','k','LineWidth',0.5);hold on


end
