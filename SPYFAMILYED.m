clc; clear;
%% 获取视频帧图
% 原视频最好不要太大，比如溜猫中毒的话360p就足够了
path1='D:\Pr视频成品\SPYFAMILY\ED.avi';   %原视频存放路径
obji=VideoReader(path1);
num=obji.NumberOfFrames; %获取视频帧数
for i=1:num 
    frame=read(obji,i);
    lj=strcat('D:\picture\SPYFAMILY\ED',num2str(i));  %帧图输出路径
    lj=strcat(lj,'.jpg');
    imwrite(frame,lj)
end 

%% 读入帧图
for i=1:num %4211
    path='D:\picture\SPYFAMILY\'; %帧图路径 
    picture_name=strcat('ED',num2str(i),'.jpg');%图片名称
    data=imread([path,picture_name]);%读取图片
%转化为灰度矩阵
    R=double(data(:,:,1));
    G=double(data(:,:,2));
    B=double(data(:,:,3));
    Gray_data = (R*299 + G*587 + B*114 + 500) / 1000;
% 按照灰度矩阵生成字符矩阵
% 网上应该有“灰度-ASCII字符”对应表，如果有这张表更好。
% 这里是简单分了十阶，参考的这篇https://zhuanlan.zhihu.com/p/38751476。
    [m,n]=size(Gray_data);
    for i=1:m
        for j=1:n
            flag=fix(Gray_data(i,j)/25);
            switch flag
                case 10
                    Gray(i,j)='.';
                case 9
                    Gray(i,j)='!';
                case 8
                    Gray(i,j)='u';
                case 7
                    Gray(i,j)='o';
                case 6
                    Gray(i,j)='a';
                case 5
                    Gray(i,j)='*';
                case 4
                    Gray(i,j)='p';
                case 3
                    Gray(i,j)='8';
                case 2
                    Gray(i,j)='m';
                case 1
                    Gray(i,j)='&';
                case 0
                    Gray(i,j)='$';
            end
        end
    end
%% 写入文本文件再输出
    filename=['D:\picture\SPYFAMILY\TEXT\','test.txt'];
    dlmwrite(filename,Gray,'delimiter',' ','newline','pc');%怼个空格进去
    fid=fopen('D:\picture\SPYFAMILY\TEXT\test.txt','r');
    clc;
    A = fscanf(fid,'%c')
    sta = fclose(fid);
    delete('test.txt');
    % 然后在MATLAB的设置中把字体改为1，点击运行之后录屏即可
    disp(A);
end