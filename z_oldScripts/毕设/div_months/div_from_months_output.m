function [ q3,q6,q9,q12 ] = div_from_months_output( temp0)
%   �����Ϸֽ�123���ȵĺ�����uvw��
%�����ĸ�����
  %----------------------���ּ���----------------------------------
    cycle=40;
    mm=3;nn=5;[q3] = div_from_months_var( cycle,mm,nn,temp0) ;%3-5��
    mm=6;nn=8;[q6] = div_from_months_var( cycle,mm,nn,temp0) ;%6-8��
    mm=9;nn=11;[q9] = div_from_months_var( cycle,mm,nn,temp0 ) ;%9-11��
    mm=12;nn=14;cycle1=39; [ q12 ] = div_from_months_var( cycle1,mm,nn,temp0 ) ;%12-2��
    q12(:,:,118,:)=temp0(:,:,480,:);  q12(:,:,119:120,:)=temp0(:,:,1:2,:);


end