I = imread('hello.jpg');
I = imcomplement(I);
imageSize = size(I);
[a,b] = size(I);
ci = [a/2,b/2,a/2];     % center and radius of circle ([c_row, c_col, r])
[xx,yy] = ndgrid((1:imageSize(1))-ci(1),(1:imageSize(2))-ci(2));
mask = uint8((xx.^2 + yy.^2)<ci(3)^2);
croppedImage = uint8(zeros(size(I)));
croppedImage(:,:,1) = I(:,:,1).*mask;




size(croppedImage);



t=imread('23.jpg');
t = im2double(t);
          t= imcomplement(t);
          
          [a,b]= size(croppedImage);
          t= imresize(t, [a,b]);
          imshow(t)
          prob  = normxcorr2(croppedImage,t);
          display(max(prob(:)))
          
cd traffictemp
    cd tempbase
    i=1;
    array=zeros(1);
        while i<=23
          t = imread(strcat(num2str(i),'.jpg'));
          t = im2double(t);
          t= imcomplement(t);
          [a,b]= size(croppedImage);
          t= imresize(t, [a,b]);
          prob  = normxcorr2(croppedImage,t);
          array(i)=(max(prob(:)));
          i=i+1;
        end
        display(max(array))
        display(array)