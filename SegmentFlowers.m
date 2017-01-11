function [NumberOfFlowers, NumberOfPetalsPerFlower] = SegmentFlowers(InputImage)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    NumberOfFlowers = 0;
    h = fspecial('gaussian', [3 3], 2);
    InputImage = imfilter(InputImage,h);
    I = graythresh(rgb2gray(InputImage));
    bw = im2bw(InputImage, I);
%     SE = strel('disk', 12);
%     bw = imdilate(bw, SE);
    % figure, imshow(bw);
    tmp = bw;
    CC = bwconncomp(bw);
    numPixels = cellfun(@numel,CC.PixelIdxList);
    [L W] = size(bw);
    for ind = 1: CC.NumObjects
       if(numPixels(1, ind) >= (L*W)/20)
           NumberOfFlowers = NumberOfFlowers + 1;
           tmp(CC.PixelIdxList{ind}) = 0;
       end
    end
    %flowers = bw - tmp;
    
    %figure, imshow(flowers);
    NumberOfPetalsPerFlower = 1;
    
end