clear all;
close all;
clc;
readObject=vision.VideoFileReader('traffic1.mp4');
s=info(readObject);
frame_rate=s.VideoFrameRate;
i=0;

c1=zeros(2,2);
c2=zeros(2,2);
while ~isDone(readObject)
    
    
    
    frame=step(readObject);
    
    fobject(:,:,1)=medfilt2(frame(:,:,1));
    fobject(:,:,2)=medfilt2(frame(:,:,2));
    fobject(:,:,3)=medfilt2(frame(:,:,3));
    
    
    fobject=im2double(fobject);
    
    frame1=rgb2ycbcr(fobject);

    frame_cr=frame1(:,:,3);
    frame_cb=frame1(:,:,2);
    rchannel=im2bw(frame_cr,0.54);
    bchannel=im2bw(frame_cb,0.6);
    rchannel=imclose(rchannel,strel('disk',5));
    bchannel=imclose(bchannel,strel('disk',5));
   imshow(fobject);
   x=colorsegment(frame,rchannel,i,c1); 
   y=colorsegment1(frame,bchannel,i,c2);
    c1=x;
   c2=y;
   %imshow(frame);
   
    
    
    i=i+1;
end

close(readObject);
