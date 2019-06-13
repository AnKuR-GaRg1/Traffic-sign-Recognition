close all;
clear all;
clc;

%reading the video
    videoObject= vision.VideoFileReader('video1.mp4');
    s=info(videoObject);
%stepping through the video.
    i=0;
    while ~isDone(videoObject)
         frame=step(videoObject);
     
     %median filter the object.
        fobject(:,:,1) = medfilt2(frame(:,:,1));
        fobject(:,:,2) = medfilt2(frame(:,:,2));
        fobject(:,:,3) = medfilt2(frame(:,:,3));
     
        fobject = im2double(fobject);
     
     %converting image to ycbcr plane
        fobject  = rgb2ycbcr(fobject);
        rchannel = fobject(:,:,3);
    
     %rchannel = histeq(rchannel);
        rchannel = im2bw(rchannel,0.60);
        rchannel = imclose(rchannel,strel('disk',5));
        colorsegment(frame,rchannel,i);
        
        i=i+1;
        if i==500
             break;
        end    
    end
