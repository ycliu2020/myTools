%%---------------------------------------------------------
% Author       : LYC
% Date         : 2020-06-09 15:50:13
% LastEditTime : 2020-08-31 09:56:39
% LastEditors  : LYC
% Description  : 
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/auto_draw_1.m
%  
%%---------------------------------------------------------
function [  ] = auto_draw_1(n1,m1,tsmean,hts,lon,lat)
%   自动化ts子图的程序
%   此处显示详细说明
set(0,'defaultfigurecolor','w')%设置画布底色为白色
set(gcf,'outerposition',get(0,'screensize'));%设置figure全屏

 if m1-n1==14
    ha = tight_subplot(5,3,[.03 .02],[.02 .02],[.1 .1]);
    %tight_subplot(Nh, Nw, gap, marg_h, marg_w)
    % 行、列、
    % gap（如[0.01, 0.1]）表示子图之间垂直方向和水平方向的间隔、
    %marg_h表示的是全部子图到figure下上边界的距离，
    % marg_w则表示的是全部子图到figure左右边界的距离
    nn=double(zeros(1,15));
    nn(1:15)=n1:m1;
else if m1-n1==15
    ha = tight_subplot(4,4,[.03 .02],[.02 .02],[.1 .1]);
    nn=double(zeros(1,16));
    nn(1:16)=n1:m1;
    end
 
    nnn=0;
    dir='G:\360data\重要数据\我的文档\MATLAB\paper\datawork\画图\中国地图\mapdata';%地图数据目录
    ma=shaperead([dir,'\中国边界数据\国界线\bou1_4p.shp']);% 读取国界shp文件，a为结构体。输入whos a 可查看结构体
    mb=shaperead([dir,'\青藏高原\DBATP_Polygon.shp']);
    lon1=[2.5 357.5];%画布经纬度范围
    lat1=[-75.5 77.5];
    for n=nn(1):nn(end);
        nnn=nnn+1;
        axes(ha(nnn));
        %     subplot(4,4,n-1)
        m_proj('Mercator','lon',lon1, 'lat',lat1);%投影坐标等预设参数'Equidistant cylindrical'
        m_pcolor(lon,lat,tsmean(:,:,n)');            %伪彩图(tsmean/ex_pre)
        %m_pcolor(lon,lat,tsmean(:,:,4)');            %伪彩图(tsmean/ex_pre)
        input=[-3 3];    %色标上下限
        a=-3:1.5:3 ;
        hold on
        %----------------------画轮廓----------------------------------
        max=[ma(:).X];may= [ma(:).Y];m_line(max,may,'color',[0 0 0],'LineWidth',0.5);hold on
        mbx=[mb(:).X];mby= [mb(:).Y];m_line(mbx,mby,'color','k','LineWidth',0.5);hold on
        
        m_coast('linewidth',.5,'color','k');                                   %海岸线
        m_grid('xtick',7,'ytick',6,'linestyle','none','tickdir','out','yaxislocation','left','fontsize',10,'color','k');%边框坐标轴选项
        colormap(mycolor(3));       %翻转颜色条colormap(flipud(mycolor(13)));%colormap(jet(4))%快速看增加和减小趋势
        caxis(input)
        % set(ax,'xticklabel',num2cell(a));%这个是标签不是具体的值%{'y = 0','1/4','1/2','3/4','y = 1'})%
        jj=num2str(n-1);
        tt=['(',jj,')'];
        title(tt,'Fontsize',14,'position',[-3.6,1.8])%加小标题
        %----------------------判断是否为ttest=1----------------------------------
        hold on
        % [x, y]=find(hts(:,:,4)==1);
        [x, y]=find(hts(:,:,n)==1);
        m_plot(lon(x),lat(y),'g.','markersize',2.5,'color','k');
    end
    ax=colorbar('position',[0.91 0.2 0.02 0.6],'fontsize',12);  %([归一化x坐标 归一化y坐标 宽度 长度])
    set(ax,'xtick',a);   %这个是颜色棒中具体的值
    
    n1=num2str(nn(1));
    n2=num2str(nn(end));
    name=[n1,'-',n2];
    fig_name=['F:\paper\paper1\图\年\年全球ts图\subplote\',name];
    export_fig( gcf , '-png'   , '-r500'  , fig_name );
    close all
end

