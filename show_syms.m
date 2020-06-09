function show_syms
% ϣ����ĸ�ͳ����ַ�һ��
%fnm = 'GreekSyms.txt'; % ���ı��ļ��������ݣ�ÿ��7���Կո�ָ���
%[d1,d2,d3,d4,d5,d6,d7] = textread(fnm,'%s%s%s%s%s%s%s');
%fy = [d1 d2 d3 d4 d5 d6 d7];
fy = {'0','Delta','delta','Gamma','gamma','Im','Lambda','lambda','Omega','omega','Phi','phi','Pi','pi';'Psi','psi','Re','Sigma','sigma','Theta','theta','Upsilon','upsilon','Xi','xi','aleph','alpha','beta';'chi','epsilon','eta','iota','kappa','mu','nabla','ni','nu','o','partial','propto','rho','tau';'varpi','varsigma','vartheta','wp','zeta','uparrow','downarrow','leftarrow','rightarrow','leftrightarrow','vee','wedge','langle','rangle';'lceil','rceil','lfloor','rfloor','neg','mid','perp','times','div','cap','cup','int','surd','prime';'subset','subseteq','supset','supseteq','in','approx','cong','equiv','neq','geq','leq','bullet','cdot','ldots';'circ','oslash','otimes','sim','pm','forall','copyright','exists','infty','oplus','spadesuit','heartsuit','clubsuit','diamondsuit';};
ss = get(0,'ScreenSize');                                   % ȡ����Ļ�ֱ���
figure('Position',[ss(4)/4 ss(3)/8 3*ss(3)/4 2*ss(4)/3]);   % ����������С
clf reset; 
h = axes('Position',[0 0 1 1],'Visible','off');             % ������ϵ���ؿ̶�
set(gcf,'Color',[1 1 1]);                                   % ������������ɫ
[m,n] = size(fy);                                           % ���ݴ�С
x0 = 0.14; y0 = 0.07; dd = 0.022;                           % ��ʾ�ı��ĳ�ʼλ����ָ�
tp1.Color = [1 0 0]; tp1.FontSize = 15;                     % ��ʾ�����ʽ
tp2.Color = [0 0 0]; tp2.FontSize = 15;
str3 = '\\';                                                % ����ʾ�ķ��� '\'
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