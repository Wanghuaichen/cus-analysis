% Barrel Distortion correction

clear;

clc;

 

% img_origin = imread('250_ori.jpg');
img_origin = imread('../250/1.jpg');
 

% Change this two parameters to improve image quality

k1 = -0.00000075;
k2 = -0.00000075;

 

img_size = size( img_origin );

img_undist = zeros( img_size );

img_undist = uint8( img_undist );

 

for l0 = 1:img_size(3)

    for l1 = 1:img_size(1)

        y = l1 - img_size(1)/2;

        for l2 = 1:img_size(2)

            x = l2 - img_size(2)/2;

            x1 = round( x * ( 1 + k1 * x * x + k2 * y * y ) );

            y1 = round( y * ( 1 + k1 * x * x + k2 * y * y ) );

            y1 = y1 + img_size(1)/2;

            x1 = x1 + img_size(2)/2;

            % if x1 or y1 exceeds boundary£¬ force them to 0(black)

            if x1 < 1 || x1 > img_size(2) || y1 < 1 || y1 > img_size(1)

                img_undist(l1,l2,l0) = 0;

            else

                img_undist(l1,l2,l0) = img_origin(y1, x1,l0);

            end

        end

    end

end

 

figure(1);

% compare the two images in one figure

subplot(121);

imshow(img_origin);
hold on
[x_origin y_origin] = ginput()
label(img_origin,x_origin,y_origin,[0,0,1]);
hold off
subplot(122);


imshow(img_undist);
hold on

k = 0.00000025;
syms x_u y_u ;
equ1 = ['(',num2str(x_origin),'-360)/(1-',num2str(k),'*(y_u-360)^2-',num2str(k),'*(x_u-640)^2)+360-x_u=0']
equ2 = ['(',num2str(y_origin),'-640)/(1-',num2str(k),'*(y_u-360)^2-',num2str(k),'*(x_u-640)^2)+640-y_u=0']
[x_update,y_update]= solve(equ1,equ2)

for i = 1:3
    if x_update(i)<1280 && x_update(i)>0 && y_update(i)<720 && y_update(i)>0
        x_up = x_update(i);
        y_up = y_update(i);
        label(img_undist,x_up,y_up,[0,1,0]);
    end
end
hold off 
m1 = (y_origin-360)/(x_origin-640)
m2 = (y_up-360)/(x_up-640)
% save the original image to 1.jpg

% imwrite(img_origin,'1.jpg');
imwrite(img_undist,'248.jpg');