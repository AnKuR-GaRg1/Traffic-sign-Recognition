img = imread('372.jpg');

imggray = rgb2gray(img);
imgray  = im2double(imggray);
imbin   = im2bw(imggray,graythresh(imggray));
imbin   = imfill(imbin,'holes');
imshow(imbin);
%cd .. 
imwrite(imbin,'dcircle1.jpg');