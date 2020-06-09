%这是一个没有写完的程序gg
%同一个figure里不同子图用不同的colormap

ss = get(0,'ScreenSize');                                   % 取得屏幕分辨率
figure('Position',[ss(4)/4 ss(3)/8 3*ss(3)/4 2*ss(4)/3]);   % 设置主窗大小
clf reset; 
set(gcf,'Color',[1 1 1]);
tp1.Color = [0 0 0]; tp1.FontSize = 15;                     % 显示字体格式
tp2.Color = [0 0 0]; tp2.FontSize = 15;
str='No.1';
left=-.05;down=0.75;
for index = 1 : n
    
end
color_hot=colormap(hot);%颜色图的提取
% mycolor=[color_hot(:,3),color_hot(:,2),color_hot(:,1)];%也可以用fliplr()函数，交换红蓝颜色通道
ax1 = axes('Position',[left down 0.15 0.2],'Visible','off'); %[离左边缘 离下边缘 自身宽 自身高]
colormap(ax1,hot);colorbar
caxis([-1 1])
text(left+1.05,down-0.85,str,tp1);

ax2 = axes('Position',[0.2 0.5 0.15 0.2],'Visible','off'); 
colormap(ax2,mycolor(12));colorbar
caxis([-1 1])
