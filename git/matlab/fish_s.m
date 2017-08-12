% Barrel Distortion correction

clear;

clc;

 
for m = 1:772

    filename = ['../248/' num2str(m) '.jpg'];
    out_filename = ['../fish_248/' num2str(m) '.jpg'];
    img_origin = imread(filename);


    % Change this two parameters to improve image quality

    k1 = -0.00000020;
    k2 = -0.00000020;



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
    
    imwrite(img_undist,out_filename);
end