close all; clear all;
clc;
% dy = 120;
% dx = 850;
% theta = -58;

fprintf('  Showing the program lasting...');tic;
imfolder = 'E:\images_fromCamara\0802lab\case1';
img_w = 720+500+1280+200;
img_h = 1280+200;
h_cam = 720;
w_cam = 1280;
for k = 1:430
    
    T_250 = [1 0 0
      0 1 0 
      0 0 1];

    T_248 = [1 0 0
      0 1 0 
     720+600 0 1];
    T_249 = [1 0 0
      0 1 0 
      720+550 500 1];

    % imfile{1} = [imfolder '\fish_250\1.jpg'];
    % imfile{2} = [imfolder '\fish_248\1.jpg'];
    % imfile{3} = [imfolder '\fish_249\1.jpg'];
    imfile{1} = [imfolder '\250\',strcat(num2str(k)),'.jpg'];
    imfile{2} = [imfolder '\248\',strcat(num2str(k)),'.jpg'];
    imfile{3} = [imfolder '\249\',strcat(num2str(k)),'.jpg'];

    I_250 = imread(imfile{1});
    I_248 = imread(imfile{2});
    I_249 = imread(imfile{3});

    mask_248 = ones(h_cam,w_cam,3);
    mask_249 = ones(h_cam,w_cam,3);

    I_250_1 = imrotate(I_250,90,'nearest');
    I_248_1 = imrotate(I_248,5,'nearest');
    I_249_1 = imrotate(I_249,-5,'nearest');
    mask_248_1 = imrotate(mask_248,5,'nearest');
    mask_249_1 = imrotate(mask_249,-5,'nearest');


    T_250 = maketform('affine',T_250);
    T_248 = maketform('affine',T_248);
    T_249 = maketform('affine',T_249);


    [I_250_1 X1 Y1]=imtransform(I_250_1,T_250);
    [I_248_1 X2 Y2]=imtransform(I_248_1,T_248);
    [I_249_1 X3 Y3]=imtransform(I_249_1,T_249);
    [mask248_1 X Y]=imtransform(mask_248_1,T_248);
    [mask249_1 X Y]=imtransform(mask_249_1,T_249);



    I_250_1=imtransform(I_250_1,T_250,'XData',[1 img_w],'YData',[1 img_h],'FillValues',0);
    I_248_1=imtransform(I_248_1,T_248,'XData',[1 img_w],'YData',[1 img_h],'FillValues',0);
    I_249_1=imtransform(I_249_1,T_249,'XData',[1 img_w],'YData',[1 img_h],'FillValues',0);
    mask_248_1=imtransform(mask_248_1,T_248,'XData',[1 img_w],'YData',[1 img_h],'FillValues',0);
    mask_249_1=imtransform(mask_249_1,T_249,'XData',[1 img_w],'YData',[1 img_h],'FillValues',0);

    png_path = sprintf('%s\\zzp_%02d.png', imfolder, 1);
    imwrite(I_248_1,png_path,'Alpha',mask_248_1(:,:,1));
    png_path = sprintf('%s\\zzp_%02d.png', imfolder, 2);
    imwrite(I_249_1,png_path,'Alpha',mask_249_1(:,:,1));



    sysorder = sprintf('enblend --output=%s\\mosaic_blend.jpg', imfolder) ;
    sysorder = sprintf('%s --wrap=horizontal', sysorder) ;
    for i = 1:2
            sysorder = sprintf('%s %s\\zzp_%02d.png',sysorder, imfolder, i) ;
    end
    system(sysorder) ;

    I_248_249 = imread([imfolder '\mosaic_blend.jpg']);

    img = I_250_1+I_248_249;
    img_path = ['./blend/img' strcat(num2str(k)) '.jpg'];
    imwrite(img,img_path);
    fprintf('done (%fs)\n',toc);
end
























