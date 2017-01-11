function [ result ] = Warp( I1, pts1, pts2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
pts1(3, :) = 1;
pts2(3, :) = 1;
W = (pts2*pts1')*(inv(pts1*pts1'));
result = GeometricLinearTransform(I1,W);
figure,imshow(result), hold on;
end