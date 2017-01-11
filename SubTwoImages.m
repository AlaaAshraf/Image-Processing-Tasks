function [ result ] = SubTwoImages( I1, I2, fract )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

imageSize = size(I1);
result = zeros(imageSize);
I2=imresize(I2, [imageSize(1), imageSize(2)]);
result = (I1 - I2);
result = uint8(Contrast(result, 0, 255));
end

