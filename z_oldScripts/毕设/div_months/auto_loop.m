function [ temp2 ] =auto_loop( patch,var,temp0,lev)
%   �Զ�ѭ��
%���룺
% cycle ��ݣ�40��
% mm ��һ���ʼ��
% nn ��һ�������
% pre,ts ԭʼ����
%   ��������ֺ�ָ�����ȵı���

for i=1:2
    datadir=  ['/data1/cz/gfa1k_all/run_spw_',patch{i},'/atm/hist/'];%['F:/paper/data/data/run_spw_',patch{i},'/atm/hist/']; %ָ�������������ڵ��ļ���
    filelist=dir([datadir,'*h0*.nc']); %ָ���������ݵ��������ļ�������h0����Ϊһ���ṹ��
    for s=1:480
        filename=[datadir,filelist(s+12).name];%��Ϊ��һ�겻��
        ncid=netcdf.open(filename,'NC_NOWRITE');
        temp1= ncread(filename,var);    %����var��859.535����24��
        temp0(:,:,s,i)=temp1(:,:,lev);netcdf.close(ncid);   % �ر��ļ�
    end
end

temp2=temp0;
end