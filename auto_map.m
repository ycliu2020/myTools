function [] = auto_map(  )
%draw outline
%   �˴���ʾ��ϸ˵��
dir='G:\360data\��Ҫ����\�ҵ��ĵ�\MATLAB\paper\datawork\��ͼ\�й���ͼ\mapdata';%��ͼ����Ŀ¼
ma=shaperead([dir,'\�й��߽�����\������\bou1_4p.shp']);mb=shaperead([dir,'\��ظ�ԭ\DBATP_Polygon.shp']);
max=[ma(:).X];may= [ma(:).Y];m_line(max,may,'color',[0 0 0],'LineWidth',0.5);hold on;mbx=[mb(:).X];mby= [mb(:).Y];m_line(mbx,mby,'color','k','LineWidth',0.5);hold on


end
