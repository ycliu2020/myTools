function [ h1,h2,h3 ] = legend_vc( pos,x,y,u,v,scl,std )
%LEGEND_VC To add legend for vector.
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

P1 = get(gca,'position');
P2 = get(gcf,'position');
width = min(P1(3)*P2(3)/6,P2(3)/10)/P2(3);
height = min(P1(4)*P2(4)/6,P2(4)/10)/P2(4);
x_lim=get(gca,'xlim');
y_lim=get(gca,'ylim');
xdom = max(x_lim)-min(x_lim);
ydom = max(y_lim)-min(y_lim);
xdom1 = xdom/P1(3)*width;
ydom1 = ydom/P1(4)*height;
xpos = 1*xdom1;
ypos = 1*ydom1;

if ischar(pos)
    if strcmp(pos,'northeast')
        pos = [P1(1)+P1(3)-width-.01,P1(2)+P1(4)-height-.01,width,height];
    elseif strcmp(pos,'southeast')
        pos = [P1(1)+P1(3)-width-.01,P1(2)+.01,width,height];
    elseif strcmp(pos,'southwest')
        pos = [P1(1)+.01,P1(2)+.01,width,height];
    elseif strcmp(pos,'northwest')
        pos = [P1(1)+.01,P1(2)+P1(4)-height-.01,width,height];
    elseif strcmp(pos,'rightshoulder')
        pos = [P1(1)+P1(3)-width,P1(2)+P1(4)+.01,width,height];
    elseif strcmp(pos,'rightfoot')
        pos = [P1(1)+P1(3)-width,P1(2)-height-.01,width,height];
    else
        error('Error position.');
    end
end

if any([ndims(x) ndims(y) ndims(u) ndims(v)]>2)
    error('Input arrays has exceeded dimensions');
elseif ~isequal(size(x),size(y),size(u),size(v))
    error('lon,lat,u,v must be same size');
end
scale_auto = Get_Autoscale(x,y,u,v);
labelx = [.25*xpos,(.25+3)*xpos];
labely = [.65*ypos,(.65+3)*ypos];
labelu = [std,0];
labelv = [0,0];
scale_label = Get_Autoscale(labelx,labely,labelu,labelv);
scale_factor = scale_auto/scale_label;
h1 = axes('Position',pos);
h2 = quiver(labelx,labely,labelu,labelv,double(scl*scale_factor));
h3 = text(double(.25*xpos),double(.3*ypos),[num2str(std),' m/s'],'fontname','Times New Roman');
set(h1,'xlim',[0 xpos],'ylim',[0 ypos],'xtick',[],'ytick',[],'Box','on')

end