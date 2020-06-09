function show_syms
% 希腊字母和常用字符一览
%fnm = 'GreekSyms.txt'; % 从文本文件调入数据（每行7个以空格分隔）
%[d1,d2,d3,d4,d5,d6,d7] = textread(fnm,'%s%s%s%s%s%s%s');
%fy = [d1 d2 d3 d4 d5 d6 d7];
fy = {'0','Delta','delta','Gamma','gamma','Im','Lambda','lambda','Omega','omega','Phi','phi','Pi','pi';'Psi','psi','Re','Sigma','sigma','Theta','theta','Upsilon','upsilon','Xi','xi','aleph','alpha','beta';'chi','epsilon','eta','iota','kappa','mu','nabla','ni','nu','o','partial','propto','rho','tau';'varpi','varsigma','vartheta','wp','zeta','uparrow','downarrow','leftarrow','rightarrow','leftrightarrow','vee','wedge','langle','rangle';'lceil','rceil','lfloor','rfloor','neg','mid','perp','times','div','cap','cup','int','surd','prime';'subset','subseteq','supset','supseteq','in','approx','cong','equiv','neq','geq','leq','bullet','cdot','ldots';'circ','oslash','otimes','sim','pm','forall','copyright','exists','infty','oplus','spadesuit','heartsuit','clubsuit','diamondsuit';};
ss = get(0,'ScreenSize');                                   % 取得屏幕分辨率
figure('Position',[ss(4)/4 ss(3)/8 3*ss(3)/4 2*ss(4)/3]);   % 设置主窗大小
clf reset; 
h = axes('Position',[0 0 1 1],'Visible','off');             % 建立轴系隐藏刻度
set(gcf,'Color',[1 1 1]);                                   % 设置主窗背景色
[m,n] = size(fy);                                           % 数据大小
x0 = 0.14; y0 = 0.07; dd = 0.022;                           % 显示文本的初始位置与分隔
tp1.Color = [1 0 0]; tp1.FontSize = 15;                     % 显示字体格式
tp2.Color = [0 0 0]; tp2.FontSize = 15;
str3 = '\\';                                                % 将显示的符号 '\'
for r = 1:n
    for c = 1:m       
        x1 = 0.02+(c-1)*x0;
        x2 = x1+dd;
        x3 = x2+0.008;
        y = 0.98-(r-1)*y0;
        str1 = fy{c,r};
        str2 = ['\' str1]; 
        text(x1,y,str2,tp1);
        text(x2,y,str3,tp2);
        text(x3,y,str1,tp2);
    end
end