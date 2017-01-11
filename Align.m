function [AlignedImage, Corners] = Align(InputImage, DW, DH)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[H, W, L] = size(InputImage);
initialCorners=ones(3,4);
Corners=initialCorners;
Corners(1,4)=DW;
Corners(2,2)=DH;
Corners(1,3)=DW;
Corners(2,3)=DH;
 for Y=1:H
     for X=1:W
         if(InputImage(Y,X,1)>100)&&(InputImage(Y,X,2)<10)&&(InputImage(Y,X,3)<10)
             initialCorners(1,1)=X;
             initialCorners(2,1)=Y;
         end
         if(InputImage(Y,X,2)>100)&&(InputImage(Y,X,1)<10)&&(InputImage(Y,X,3)<10)
             initialCorners(1,4)=X;
             initialCorners(2,4)=Y;
         end
         if(InputImage(Y,X,3)>100)&&(InputImage(Y,X,1)<10)&&(InputImage(Y,X,2)<10)
             initialCorners(1,2)=X;
             initialCorners(2,2)=Y;
         end
         if(InputImage(Y,X,1)>50)&&(InputImage(Y,X,2)>50)&&(InputImage(Y,X,3)<10)
             initialCorners(1,3)=X;
             initialCorners(2,3)=Y;
         end
     end
 end
 initialCorners
 %W = Warp(InputImage, initialCorners, Corners);
 %AlignedImage=imwarp(InputImage,W);
 InputImage=Warp2(InputImage,Corners,initialCorners);
 x=0;y=0;
 [H, W, L] = size(InputImage);
  for Y=1:H
     for X=1:W
         if(InputImage(Y,X,1)>100)&&(InputImage(Y,X,2)<10)&&(InputImage(Y,X,3)<10)
             x=X;
             y=Y;
         end
     end
  end
  AlignedImage=imcrop(InputImage,[x y DW DH]);
end

