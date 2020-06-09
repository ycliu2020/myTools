function [ ] = find3DMaxMin(x1,p)
% x is 3D matrx
% p is parameter that 1==max, 2==min
% need to find the max(x)'s location
x=squeeze(x1);
if p==1
    maxx=(max(max(max(x))));
    L_maxx=find(x==maxx);
elseif p==2
    maxx=(min(min(min(x))));
    L_maxx=find(x==maxx);
end
    [u,v,w]=ind2sub(size(x),L_maxx);
    disp('max=')
    disp(maxx)
    disp('dim1=')
    disp(u)
    disp('dim2=')
    disp(v)
    disp('dim3=')
    disp(w)

