%mif转换coe代码
%首先在文件夹中导入数据
%在导入数据界面里面进行元组数据的导入到工作台（好像只有元组可以导文本）
%工作台中显示出自己想要的数据后进行参数修改
%记住不要进行清除全部
DEPTH = 621;%修改深度
WIDTH = 90;%修改宽度(可以在mif中自行查看，看占几个字符就行)
%
clc
M  = char(headV2);
fid_s = fopen('headV2.coe', 'wt');
fprintf(fid_s, '%s\n', 'MEMORY_INITIALIZATION_RADIX = 2;');
fprintf(fid_s, '%s\n', 'MEMORY_INITIALIZATION_VECTOR =');

for i=1:DEPTH
    for j=1:WIDTH
        fprintf(fid_s, '%s', M(i,j));
    end
    if (i~=DEPTH)
     fprintf(fid_s, '%s',',');
     fprintf(fid_s, '\n');
    end
end
fprintf(fid_s, '%s', ';');
fclose(fid_s);
disp('===================转换完成=========================');