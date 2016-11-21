function [YinImage, YangImage] = SplitYinYang(InputImage)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    [L W H] = size(InputImage);
    if(H > 2)
        bw = rgb2gray(InputImage);
    else 
        bw = InputImage;
    end   
    SE = strel('square', 3);
    YinImage = imerode(bw, SE);
    YinImage = imfill(YinImage);
    SE = strel('disk', round(7 * (L / 260)));
    YinImage = imdilate(YinImage, SE);
    YinImage = imerode(YinImage, SE);
    
    
    bw1 = bw;
    CC = bwconncomp(bw);
    numPixels = cellfun(@numel,CC.PixelIdxList);
    [Yang,idx] = max(numPixels);
    [Background,idx] = max(numPixels < Yang);
    bw(CC.PixelIdxList{idx}) = 0;
    [Yang,idx] = max(numPixels);
    bw1(CC.PixelIdxList{idx}) = 0;

    YangImage = bw & (~bw1);
end



%     [L,num] = bwlabeln(bw,8);
%     for y = 1: num
%     [r c] = find(L == y);
%     rc = [r c];
%     YinImage = zeros(size(bw));
%     [a b] = size(rc);
%     for x = 1: a
%        YinImage(rc(x, 1), rc(x, 2)) = 255; 
%     end
%     figure, imshow(YinImage);
%     end