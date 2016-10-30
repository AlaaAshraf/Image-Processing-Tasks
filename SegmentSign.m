function [SegmentedSign, SignShape] = SegmentSign(InputImage)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    %InputImage = rgb2gray(InputImage);
    h = fspecial('average', [5 5]);
    InputImage = imfilter(InputImage,h);
    figure,imshow(InputImage);
    
    
    [centers, radii] = imfindcircles(InputImage,[100, 1000],'ObjectPolarity','dark');
    circlesNum = size(centers)
    maxxR=0;
    maxxI=-1;
    for i=1:circlesNum
        if radii(i)>maxxR
            maxxR=radii(i);
            maxxI = i;
        end
    end
    if(maxxI~=-1)
    minX = centers(maxxI,1)-maxxR;
    minY = centers(maxxI,2)-maxxR;
    SegmentedSign = imcrop(InputImage, [minX, minY, 2*maxxR, 2*maxxR]);
    SignShape = 'Circle';
    else
        SegmentedSign = InputImage;
        SignShape = 'Null';
    end
        
end

