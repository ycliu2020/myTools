function [ r99 ] = R99p( n ,opre )
%   求极端降水阈值r99=具体的阈值
%   opre为三维数组，第三维为变量，，前两位为经纬度
s=0.99*(n+0.38)+0.31;
if rem(s,1)==0
   r99=opre(:,:,s);
else
  p1=(fix(s)-0.31)/(n+0.38);
  p2=(fix(s+1)-0.31)/(n+0.38);
  s1=fix(s);
  %线性插值（求线性方程）
  k=(opre(:,:,s1)-opre(:,:,s1+1))/(p1-p2);
  b=opre(:,:,s1+1)-k*p2;
  r99= k*0.99+b;
end

end
   
