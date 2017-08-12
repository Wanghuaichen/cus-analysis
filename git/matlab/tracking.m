

close all
figure;
imshow(I_248);
hold on
[x y] = ginput(1);
plot(x,y,'p', 'MarkerSize', 15, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'g');
hold off

%% 仿射旋转变换，默认是顺时针旋转
theta_248 = -3;
R_248 = [cos(theta_248*pi/180) sin(theta_248*pi/180) 0
    -sin(theta_248*pi/180) cos(theta_248*pi/180) 0
    0 0 1];
R_248 = maketform('affine',R_248);
[I_248_R X Y]=imtransform(I_248,R_248);%,'XData',[-720 2000],'YData',[1 2000],'FillValues',0);
figure;
%% 旋转后点的位置
imshow(I_248_R)
hold on

AA = round(tformfwd(R_248,x,y));
if theta_248>0
    x_R = AA(1)+720*sin(theta_248*pi/180);
    y_R = AA(2);
else    
    x_R = AA(1);
    y_R = AA(2)-1280*sin(theta_248*pi/180);
end
plot(x_R,y_R,'p', 'MarkerSize', 15, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'g');
hold off

%% 在合成后的位置
figure;
imshow(img);
hold on
x_T = x_R+dx_248;
y_T = y_R+dy_248;
plot(x_T,y_T,'p', 'MarkerSize', 15, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'g');
hold off

%     
%     
%     
%     
% % end
% pause(2)
% 
% close all













