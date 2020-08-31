function [ h1,h2,h3,h4 ] = legend_wb( pos,Num,color)
%LEGEND_VC To add legend for windbarb.
%   Input the position of legend_wb for the handles of legend.
%   h1 for axis;
%   h2,h3 for line;
%   h4 for text
%
%   Num for wind speed
%   color for color
%   AUTHOR sfhstcn2
%   CONTACT sfh_st_cn2@163.com

P1 = get(gca,'position');
P2 = get(gcf,'position');
width = min(P1(3)*P2(3)/6,P2(3)/10)/P2(3);
height = min(P1(4)*P2(4)/6,P2(4)/10)/P2(4);

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

h1 = axes('Position',pos,'xtick',-100,'ytick',-100,'Box','on','xlim',[0 1],'ylim',[0 1]);
lth = .45;
x1 = 1/2-lth/2;
x2 = 1/2+lth/2;
y = .6;
lth2 = .452*lth;
x3 = x1-lth2*cos(70*pi/180);
y3 = y+lth2*sin(70*pi/180);
mv = (x2-x3)/2-(x2-x1)/2;
h2 = line([x1+mv x2+mv],[y y],'color',color);
h3 = line([x1+mv x3+mv],[y y3],'color',color);
h4 = text(.25,.3,[Num,' m/s'],'fontname','Times New Roman');

end