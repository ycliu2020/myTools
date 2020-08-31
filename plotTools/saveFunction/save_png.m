function [ ] = save_png(fig_name)
% save as high quailty figure(png)  
% fig_name is char which is your output figure name
%   
if ~exist('fig_name','var')
temp=pwd;
fig_name=[temp,'/output'];
end
export_fig( gcf,'-png','-r500',fig_name );
