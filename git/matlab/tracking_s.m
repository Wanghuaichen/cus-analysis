

close all
ratio_x = size(img_basic,2)/size(I_248_1,2);
ratio_y = size(img_basic,1)/size(I_248_1,1);

%% 248摄像头跟踪
% 计算旋转矩阵
theta_248 = -theta_248;
R_248 = [cos(theta_248*pi/180) sin(theta_248*pi/180) 0
-sin(theta_248*pi/180) cos(theta_248*pi/180) 0
0 0 1];
R_248 = maketform('affine',R_248);
% [I_248_R X Y]=imtransform(I_248,R_248);%,'XData',[-720 2000],'YData',[1 2000],'FillValues',0);

%获取轨迹坐标
figure;
imshow(I_248);
hold on
[x_248 y_248] = ginput;
label(I_248,x_248,y_248,[0,0,1]);
hold off

% 计算旋转后的坐标
AA = round(tformfwd(R_248,x_248,y_248));
if theta_248>0
    x_248_R = AA(:,1)+720*sin(theta_248*pi/180);
    y_248_R = AA(:,2);
else    
    x_248_R = AA(:,1);
    y_248_R = AA(:,2)-1280*sin(theta_248*pi/180);
end

%得到平移后的坐标
x_248_T = (x_248_R*sx_248*sx_248+dx_248)*ratio_x;
y_248_T = (y_248_R*sy_248*sy_248+dy_248)*ratio_y;


%% 249摄像头跟踪
theta_249 = -theta_249;
R_249 = [cos(theta_249*pi/180) sin(theta_249*pi/180) 0
-sin(theta_249*pi/180) cos(theta_249*pi/180) 0
0 0 1];
R_249 = maketform('affine',R_249);
% [I_249_R X Y]=imtransform(I_249,R_249);%,'XData',[-720 2000],'YData',[1 2000],'FillValues',0);

%获取轨迹坐标
figure;
imshow(I_249);
hold on
[x_249 y_249] = ginput;
label(I_249,x_249,y_249,[0,1,0]);
hold off

% 计算旋转后的坐标
AA = round(tformfwd(R_249,x_249,y_249));
if theta_249>0
    x_249_R = AA(:,1)+720*sin(theta_249*pi/180);
    y_249_R = AA(:,2);
else    
    x_249_R = AA(:,1);
    y_249_R = AA(:,2)-1280*sin(theta_249*pi/180);
end

%得到平移后的坐标
x_249_T = (x_249_R*sx_249*sx_249+dx_249)*ratio_x;
y_249_T = (y_249_R*sy_249*sy_249+dy_249)*ratio_y;

%% 250摄像头的跟踪
theta_250 = -theta_250;
R_250 = [cos(theta_250*pi/180) sin(theta_250*pi/180) 0
-sin(theta_250*pi/180) cos(theta_250*pi/180) 0
0 0 1];
R_250 = maketform('affine',R_250);
figure;
imshow(I_250);
hold on
[x_250 y_250] = ginput;
label(I_250,x_250,y_250,[1,0,0]);
hold off

AA = round(tformfwd(R_250,x_250,y_250));
if theta_250>0
    x_250_R = AA(:,1)+720*sin(theta_250*pi/180);
    y_250_R = AA(:,2);
else    
    x_250_R = AA(:,1);
    y_250_R = AA(:,2)-1280*sin(theta_250*pi/180);
end
figure;
imshow(I_250_1);
hold on
x_250_T1=x_250_R*sx_250*sx_250+dx_250;
y_250_T1=y_250_R*sy_250*sy_250+dy_250;
label(I_250_1,x_250_T1,y_250_T1,[1,0,0]);
hold off
%得到平移后的坐标
x_250_T = (x_250_R*sx_250*sx_250+dx_250)*ratio_x;
y_250_T = (y_250_R*sy_250*sy_250+dy_250)*ratio_y;


%% 合并后的坐标显示
figure;
imshow(img_out);
hold on
label(img,[x_248_T],[y_248_T],[0,0,1]);
label(img,[x_249_T],[y_249_T],[0,1,0]);
label(img,[x_250_T],[y_250_T],[1,0,0]);
% label(img,[x_248_T;x_249_T;x_250_T],[y_248_T;y_249_T;y_250_T],[1,1,1]);
hold off















