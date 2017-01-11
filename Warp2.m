function [ result ] = Warp2( I1, pts2, pts1 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
W = (pts2*pts1')*(inv(pts1*pts1'));
result = GeometricLinearTransform(I1,W);
end