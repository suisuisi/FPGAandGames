%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This MATLAB code converts the .txt 16-bit PCM file to .mif  %%
%% to use as a ROM table for WM8731 Audio CODEC                %%
%% Author: Ahmad Al-Astal                                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('5_Centimeters_Per_Second_Clip_16bit_PCM_13_Seconds_HEX.txt','r'); % specify .txt file name, W means write, r means read, case sensitive WATCH OUT!
fid2 = fopen ('5_Centimeters_Per_Second_Clip_16bit_PCM_13_Seconds_HEX_ROM.txt','w');
formatSpec = '%x';
A = fscanf(fid,formatSpec);
array_length = length(A);
if(fid2)
    fprintf(fid2,'WIDTH = 16;\n');
    fprintf(fid2,'DEPTH = %d;\n',array_length);
    fprintf(fid2,'ADDRESS_RADIX = HEX;\n');
    fprintf(fid2,'DATA_RADIX = HEX;\n'); % Don't forget to change HEX to DECIMAL when needed or vice versa
    fprintf(fid2,'CONTENT BEGIN\n\n');
    for x = 1:array_length
        fprintf(fid2,'%X: ',x);
        fprintf(fid2,'%.4X\n',A(x));
    end
    fprintf(fid2,'END;\n');
    fclose(fid2);
end