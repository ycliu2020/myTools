%  colorbargap
% %��Ϊ���Ⱦ���ɫ���Ļ���ʾʾ������
dlevels = a ;%����ʵ�ʷ�Χ
temp=draw_data;%ʵ������
for k = 1 : length(dlevels) - 1
    draw_data(temp>dlevels(k) & temp<=dlevels(k+1)) = k ;
end

draw_data(draw_data==dlevels(1)) = 1 ;
% cmap = colormap(jet(length(dlevels) - 1)) ;
% 
% colormap(cmap) ;
caxis([0 length(dlevels)-1]) ;
cbar = colorbar ;
a1=set(cbar,'Ticks',[0,1,2,3,4,5,6,7,8,9],'TickLabels',dlevels) ;