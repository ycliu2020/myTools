%generate a image matrix 
imgMatrix=ones(400,600,3);%3==rgb 
imgMatrix(151:250,:,1)=0;%151��250����,���е���
imgMatrix(151:250,:,2)=50/255;
imgMatrix(151:250,:,3)=130/255;
imgMatrix(:,151:250,1)=0;%���е���,151��250����
imgMatrix(:,151:250,2)=50/255;
imgMatrix(:,151:250,3)=130/255;