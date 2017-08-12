close all; clear all;
clc;
% dy = 120;
% dx = 850;
% theta = -58;

fprintf('  Showing the program lasting...');tic;
imfolder = '..';
img_w = 720+500+1280+500;
img_h = 1280+500;
h_cam = 720;
w_cam = 1280;

dx_248 = 720+820;
dy_248 = 470;
dx_249 = 720+590;
dy_249 = 985;
dx_250 =300;
dy_250 = -150;

sx_248 = 0.98;
sy_248 = 0.98;
sx_249 = 1.02;
sy_249 = 1.02;
sx_250 = 1.15;
sy_250 = 1.35;

theta_248 =2;
theta_249 = -2;
theta_250 = 90;

T_250 = [sx_250 0 0
  0 sy_250 0 
  dx_250 dy_250 1];

T_248 = [sx_248 0 0
  0 sy_248 0 
 dx_248 dy_248 1];
T_249 = [sx_249 0 0
  0 sy_249 0 
  dx_249 dy_249 1];

% imfile{1} = [imfolder '\fish_250\1.jpg'];
% imfile{2} = [imfolder '\fish_248\1.jpg'];
% imfile{3} = [imfolder '\fish_249\1.jpg'];
imfile{1} = [imfolder '\fish_250\1.jpg'];
imfile{2} = [imfolder '\fish_248\1.jpg'];
imfile{3} = [imfolder '\fish_249\1.jpg'];

I_250 = imread(imfile{1});
I_248 = imread(imfile{2});
I_249 = imread(imfile{3});

mask_248 = ones(h_cam,w_cam,3);
mask_249 = ones(h_cam,w_cam,3);

%% 各个摄像头的旋转角度;imtotate默认是逆时针旋转

I_250_1 = imrotate(I_250,theta_250,'nearest');
I_248_1 = imrotate(I_248,theta_248,'nearest');
I_249_1 = imrotate(I_249,theta_249,'nearest');
mask_248_1 = imrotate(mask_248,theta_248,'nearest');
mask_249_1 = imrotate(mask_249,theta_249,'nearest');

%% 生成仿射结构体
T_250 = maketform('affine',T_250);
T_248 = maketform('affine',T_248);
T_249 = maketform('affine',T_249);


%% 将各个图像应用仿射变换
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

%% enblend248 和249
% png_path = sprintf('%s\\zzp_%02d.png', imfolder, 1);
% imwrite(I_248_1,png_path,'Alpha',mask_248_1(:,:,1));
% png_path = sprintf('%s\\zzp_%02d.png', imfolder, 2);
% imwrite(I_249_1,png_path,'Alpha',mask_249_1(:,:,1));
% 
% 
% 
% sysorder = sprintf('enblend --output=%s\\mosaic_blend.jpg', imfolder) ;
% sysorder = sprintf('%s --wrap=horizontal', sysorder) ;
% for i = 1:2
%         sysorder = sprintf('%s %s\\zzp_%02d.png',sysorder, imfolder, i) ;
% end
% system(sysorder) ;
% 
% I_248_249 = imread([imfolder '\mosaic_blend.jpg']);
% I_248_249 = imresize(I_248_249,[img_h,img_w]);

%% 将250和248、249一起显示
% img = I_250_1+I_248_249;
I_248_1 = imresize(I_248_1,[img_h,img_w]);
I_249_1 = imresize(I_249_1,[img_h,img_w]);
img = I_250_1+I_248_1+I_249_1;
imwrite(img,'img.jpg');
% figure;
% imshow(img);

%% 将图像输出到basic上边
img_basic = imread('../basic.jpg');
figure;imshow(img_basic);
h_b = size(img_basic,1);
w_b = size(img_basic,2);
img = imresize(img,[h_b,w_b]);
img_out = img +img_basic;
figure;imshow(img_out);






fprintf('done (%fs)\n',toc);
tracking_s






















