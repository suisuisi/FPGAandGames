%mifת��coe����
%�������ļ����е�������
%�ڵ������ݽ����������Ԫ�����ݵĵ��뵽����̨������ֻ��Ԫ����Ե��ı���
%����̨����ʾ���Լ���Ҫ�����ݺ���в����޸�
%��ס��Ҫ�������ȫ��
DEPTH = 8192;%�޸����
WIDTH = 16;%�޸Ŀ��(������mif�����в鿴����ռ�����ַ�����)
%
clc
M  = char(font);
fid_s = fopen('font.coe', 'wt');
fprintf(fid_s, '%s\n', 'MEMORY_INITIALIZATION_RADIX = 16;');
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
disp('===================ת�����=========================');