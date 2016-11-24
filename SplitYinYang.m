function [YinImage, YangImage] = SplitYinYang(InputImage)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    bw = im2bw(InputImage, 0.5);
   
    tmp = ~bw;
    %Get the background (background is black)
    YinImage = imfill(tmp, 'holes');
    %Get an inverted Image without background
    I = xor(YinImage , tmp);
    
    %Remove the circle in the Yang part
    [L,num] = bwlabel( I );
    counts = sum(bsxfun(@eq,L(:),1:num));
    [~,ind] = max(counts);
    Yin = ~(L==ind);
    
    %Get the YinImage
    YinImage = I - Yin; 
    YangImage = bw;
    
end