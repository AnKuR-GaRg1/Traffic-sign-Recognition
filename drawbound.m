          
function drawbound(f,test)

          X = rgb2gray(f);
          B = rgb2gray(test);
          C = normxcorr2(B,X);
          [ypeak,xpeak] = find(C==max(C(:)));
          yoffSet = ypeak-size(B,1);
          xoffSet = xpeak-size(B,2);
          imrect(gca, [xoffSet+1,yoffSet+1, size(B,2),size(B,1)]);
          drawnow
end