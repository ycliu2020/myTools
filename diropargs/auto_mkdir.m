function [] = auto_mkdir(path,opt)

% �ж��Ƿ����Ŀ¼, �������򴴽�
% optΪ��ѡ������, ��������ʾ��ʾ��Ϣ
if nargin==1
  if ~exist(path,'dir')
    mkdir(path)         % �������ڣ��򴴽�һ��Ŀ¼
    else
      disp('hint: the directory already exist, no-ops')
  end 
  else
    if ~exist(path,'dir')
      mkdir(path)         % �������ڣ��򴴽�һ��Ŀ¼
    end 
end


