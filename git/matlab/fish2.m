
%% ��ͷͰ��ʧ��У��(�̽���ͷ)
img_origin1 = imread('../248/1.jpg');%%��ȡͼƬ
img_origin = rgb2gray(img_origin1);%%��R��G��BΪ�Ὠ���ռ�ֱ������ϵ����RGBͼ��ÿ�����ص���ɫ�����ø���ά�ռ��һ��������ʾ
k1 = -2 * 10^(-7);   % �α����������ʵ���������
k2 = -2 * 10^(-7);
cx = 116;
cy = 26;
img_size = size( img_origin );
img_undist = zeros( img_size(1)+cy*2,img_size(2)+cx*2 ); %%����һ��*��*�е������
new_size = size(img_undist);
img_undist = uint8( img_undist );
%% У��
tic                                   %%�������浱ǰʱ��
counter = zeros(img_size);
counter = uint8(counter);
error = zeros(new_size);
error = double(error);
yy = zeros(img_size);
xx = zeros(img_size);
for l1 = 1:(img_size(1)+cy*2)  % ��ֱ����

    y = l1 - img_size(1)/2-cy;

    for l2 = 1:(img_size(2)+cx*2)  % ˮƽ����

        x = l2 - img_size(2)/2-cx;

        x1 = round( x * ( 1 + k1 * x * x + k1 * y * y ) ); %%roundΪȡ����ȡ���������
        x1_err =  x * ( 1 + k1 * x * x + k1 * y * y ) - x1;
        y1 = round( y * ( 1 + k2 * x * x + k2 * y * y ) );
        y1_err =  y * ( 1 + k2 * x * x + k2 * y * y ) - y1;
        err = x1_err * x1_err + y1_err * y1_err;
        y1 = y1 + img_size(1)/2;
        x1 = x1 + img_size(2)/2;


        if y1>0 && y1<(img_size(1)+1) && x1>0 && x1<(img_size(2)+1)
            yy(y1,x1) = l1;
            xx(y1,x1) = l2;
            error(l1,l1) = err;    
            counter(y1,x1)=counter(y1,x1)+1;
            img_undist(l1,l2) = img_origin(y1, x1);
        end
    end
end
toc  
%% ԭͼ�õĵط�������
img_lost = img_origin;
for i=1:img_size(1)
    for j=1:img_size(2)
        if xx(i,j)>0 && yy(i,j)>0 
            img_lost(i,j) = img_origin(i,j);
        else
            img_lost(i,j) = 255;
        end
    end
end
figure(1),imshow(img_lost);title('ԭͼ�õĵط�');
%% У���Ժ��ͼ���ظ��ĵط���������Ӧԭͼ�ϵ�һ���㣩
img_lost2 = img_undist;
for i=1:img_size(1)
    for j=1:img_size(2)
        if xx(i,j)>0 && yy(i,j)>0
            img_lost2(yy(i,j),xx(i,j)) = 255;
        end
    end
end
figure(2),imshow(img_lost2);title('У�����ͼ���ظ��ĵط�');
%% �ҵ�У���Ժ�ͼ����ӽ���ȷ�ĵ㣨�кܶ��ظ���
error_last = error;
for l1 = 1:(img_size(1)+cy*2)  % ��ֱ����

    y = l1 - img_size(1)/2-cy;

    for l2 = 1:(img_size(2)+cx*2)  % ˮƽ����

        x = l2 - img_size(2)/2-cx;

        x1 = round( x * ( 1 + k1 * x * x + k1 * y * y ) );
        y1 = round( y * ( 1 + k2 * x * x + k2 * y * y ) );
        y1 = y1 + img_size(1)/2;
        x1 = x1 + img_size(2)/2;

        if y1>0 && y1<(img_size(1)+1) && x1>0 && x1<(img_size(2)+1)  
            if counter(y1,x1) > 1 && error(l1,l2) < error_last(y1,x1)
                    yy(y1,x1) = l1;
                    xx(y1,x1) = l2;
                    error_last(y1,x1) = error(l1,l2);
            end

        end
    end
end
%% ��˹�˲�:
img_temp1=img_undist;
img_temp1=uint32(img_temp1);
for l1 = 2:(img_size(1)+cy*2-1)  % ��ֱ����  

    for l2 = 2:(img_size(2)+cx*2-1)  % ˮƽ����
        if l1~=1 &&l2~=1
            all_temp = ( 8*img_temp1(l1,l2)+img_temp1(l1-1,l2-1)+2*img_temp1(l1-1,l2)+img_temp1(l1-1,l2+1)+2*img_temp1(l1-1,l2)+2*img_temp1(l1,l2+1)+img_temp1(l1+1,l2-1)+2*img_temp1(l1+1,l2)+img_temp1(l1+1,l2+1) )/20;
            img_temp1(l1,l2) = all_temp;
        end        
    end
end
img_temp1=uint8(img_temp1);
%% ��ֵ�˲�
img_temp2=img_undist;
uint8 aValue;
for l1 = 2:(img_size(1)+cy*2-1)  % ��ֱ����  

    for l2 = 2:(img_size(2)+cx*2-1)  % ˮƽ����
            aValue(1) = img_undist(l1-1,l2-1);
            aValue(2) = img_undist(l1-1,l2);
            aValue(3) = img_undist(l1-1,l2+1);
            aValue(4) = img_undist(l1,l2-1);
            aValue(5) = img_undist(l1,l2);
            aValue(6) = img_undist(l1,l2+1);
            aValue(7) = img_undist(l1+1,l2-1);
            aValue(8) = img_undist(l1+1,l2);
            aValue(9) = img_undist(l1+1,l2+1);

%             for i=1:9
%                 for j=1:(9-i)
%                     if aValue(j)>aValue(j+1)
%                         bTemp = aValue(j);
%                         aValue(j) = aValue(j+1);
%                         aValue(j+1) = bTemp;
%                     end
%                 end
%             end
            Sort_result = sort(aValue);
            img_temp2(l1,l2) = aValue(5);     
    end
end
string2 = strcat('У��ͼ��',num2str(new_size(1)),'*',num2str(new_size(2)));
figure(4);
subplot(221); imshow(img_origin);title('ԭͼ��480*640');
subplot(222); imshow(img_undist);title(string2);
subplot(223); imshow(img_temp1);title('��˹�˲�');
subplot(224); imshow(img_temp2);title('��ֵ�˲�');























