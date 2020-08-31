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
%   �Զ���ts��ͼ�ĳ���
%   �˴���ʾ��ϸ˵��
set(0,'defaultfigurecolor','w')%���û�����ɫΪ��ɫ
set(gcf,'outerposition',get(0,'screensize'));%����figureȫ��

 if m1-n1==14
    ha = tight_subplot(5,3,[.03 .02],[.02 .02],[.1 .1]);
    %tight_subplot(Nh, Nw, gap, marg_h, marg_w)
    % �С��С�
    % gap����[0.01, 0.1]����ʾ��ͼ֮�䴹ֱ�����ˮƽ����ļ����
    %marg_h��ʾ����ȫ����ͼ��figure���ϱ߽�ľ��룬
    % marg_w���ʾ����ȫ����ͼ��figure���ұ߽�ľ���
    nn=double(zeros(1,15));
    nn(1:15)=n1:m1;
else if m1-n1==15
    ha = tight_subplot(4,4,[.03 .02],[.02 .02],[.1 .1]);
    nn=double(zeros(1,16));
    nn(1:16)=n1:m1;
    end
 
    nnn=0;
    dir='G:\360data\��Ҫ����\�ҵ��ĵ�\MATLAB\paper\datawork\��ͼ\�й���ͼ\mapdata';%��ͼ����Ŀ¼
    ma=shaperead([dir,'\�й��߽�����\������\bou1_4p.shp']);% ��ȡ����shp�ļ���aΪ�ṹ�塣����whos a �ɲ鿴�ṹ��
    mb=shaperead([dir,'\��ظ�ԭ\DBATP_Polygon.shp']);
    lon1=[2.5 357.5];%������γ�ȷ�Χ
    lat1=[-75.5 77.5];
    for n=nn(1):nn(end);
        nnn=nnn+1;
        axes(ha(nnn));
        %     subplot(4,4,n-1)
        m_proj('Mercator','lon',lon1, 'lat',lat1);%ͶӰ�����Ԥ�����'Equidistant cylindrical'
        m_pcolor(lon,lat,tsmean(:,:,n)');            %α��ͼ(tsmean/ex_pre)
        %m_pcolor(lon,lat,tsmean(:,:,4)');            %α��ͼ(tsmean/ex_pre)
        input=[-3 3];    %ɫ��������
        a=-3:1.5:3 ;
        hold on
        %----------------------������----------------------------------
        max=[ma(:).X];may= [ma(:).Y];m_line(max,may,'color',[0 0 0],'LineWidth',0.5);hold on
        mbx=[mb(:).X];mby= [mb(:).Y];m_line(mbx,mby,'color','k','LineWidth',0.5);hold on
        
        m_coast('linewidth',.5,'color','k');                                   %������
        m_grid('xtick',7,'ytick',6,'linestyle','none','tickdir','out','yaxislocation','left','fontsize',10,'color','k');%�߿�������ѡ��
        colormap(mycolor(3));       %��ת��ɫ��colormap(flipud(mycolor(13)));%colormap(jet(4))%���ٿ����Ӻͼ�С����
        caxis(input)
        % set(ax,'xticklabel',num2cell(a));%����Ǳ�ǩ���Ǿ����ֵ%{'y = 0','1/4','1/2','3/4','y = 1'})%
        jj=num2str(n-1);
        tt=['(',jj,')'];
        title(tt,'Fontsize',14,'position',[-3.6,1.8])%��С����
        %----------------------�ж��Ƿ�Ϊttest=1----------------------------------
        hold on
        % [x, y]=find(hts(:,:,4)==1);
        [x, y]=find(hts(:,:,n)==1);
        m_plot(lon(x),lat(y),'g.','markersize',2.5,'color','k');
    end
    ax=colorbar('position',[0.91 0.2 0.02 0.6],'fontsize',12);  %([��һ��x���� ��һ��y���� ��� ����])
    set(ax,'xtick',a);   %�������ɫ���о����ֵ
    
    n1=num2str(nn(1));
    n2=num2str(nn(end));
    name=[n1,'-',n2];
    fig_name=['F:\paper\paper1\ͼ\��\��ȫ��tsͼ\subplote\',name];
    export_fig( gcf , '-png'   , '-r500'  , fig_name );
    close all
end

