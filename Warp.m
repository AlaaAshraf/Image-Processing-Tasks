function [ result ] = Warp( I1, pts2, pts1 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
W=(pts2*pts1')*(inv(pts1*pts1'));
result = GeometricLinearTransformation(I1,W);
end

