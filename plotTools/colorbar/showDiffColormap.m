%����һ��û��д��ĳ���gg
%ͬһ��figure�ﲻͬ��ͼ�ò�ͬ��colormap

ss = get(0,'ScreenSize');                                   % ȡ����Ļ�ֱ���
figure('Position',[ss(4)/4 ss(3)/8 3*ss(3)/4 2*ss(4)/3]);   % ����������С
clf reset; 
set(gcf,'Color',[1 1 1]);
tp1.Color = [0 0 0]; tp1.FontSize = 15;                     % ��ʾ�����ʽ
tp2.Color = [0 0 0]; tp2.FontSize = 15;
str='No.1';
left=-.05;down=0.75;
for index = 1 : n
    
end
color_hot=colormap(hot);%��ɫͼ����ȡ
% mycolor=[color_hot(:,3),color_hot(:,2),color_hot(:,1)];%Ҳ������fliplr()����������������ɫͨ��
ax1 = axes('Position',[left down 0.15 0.2],'Visible','off'); %[�����Ե ���±�Ե ����� �����]
colormap(ax1,hot);colorbar
caxis([-1 1])
text(left+1.05,down-0.85,str,tp1);

ax2 = axes('Position',[0.2 0.5 0.15 0.2],'Visible','off'); 
colormap(ax2,mycolor(12));colorbar
caxis([-1 1])
