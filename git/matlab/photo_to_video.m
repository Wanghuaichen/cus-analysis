
clear all;
close all;
clc;

imfolder = '..\';
vidObj=VideoWriter([imfolder '\250_ori.avi']);  
open(vidObj);  
aviobj.Quality = 100;  
aviobj.Fps = 12;  
aviobj.compression='None';  
for i=1:772   ;%此处修改成自己的范围，起始位置  
%       fname=strcat('E:\images_fromCamara\0715\case3\mosaic_global\mosaic_global',num2str(i),'.jpg'); 
    imfile{1} = [imfolder '\250\',strcat(num2str(i)),'.jpg'];
%     fname=strcat('E:\images_fromCamara\0717\case1\mosaic_global\mosaic_global',num2str(i),'.jpg');  
      adata=imread(imfile{1});  
      writeVideo(vidObj,adata);  
 end  
close(vidObj);  