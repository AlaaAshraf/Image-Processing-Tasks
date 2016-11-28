function [NumberOfFlowers, NumberOfPetalsPerFlower] = SegmentFlowers(InputImage)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    bw = im2bw(InputImage, 0.5);
    figure, imshow(bw);
    NumberOfFlowers = 5;
    NumberOfPetalsPerFlower = 5;
end

