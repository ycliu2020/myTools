function bln_pacific()
load ocean2;
mcolor = [221 221 221]/255;
stno = 1;
while(stno<length(lon))
    num = lon(stno);
    stno = stno + 1;
    patch(lon(stno:stno + num-1),lat(stno:stno + num-1),mcolor,'EdgeColor','b');hold on;
    stno = stno + num;
end
axis equal;
axis([0 360 -90 90]);