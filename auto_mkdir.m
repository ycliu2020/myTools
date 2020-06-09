function [] = auto_mkdir(path,opt)

% 判断是否存在目录, 不存在则创建
% opt为可选输入项, 输入则不显示提示信息
if nargin==1
  if ~exist(path,'dir')
    mkdir(path)         % 若不存在，则创建一个目录
    else
      disp('hint: the directory already exist, no-ops')
  end 
  else
    if ~exist(path,'dir')
      mkdir(path)         % 若不存在，则创建一个目录
    end 
end


