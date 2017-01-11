function [YinImage, YangImage] = SplitYinYang(InputImage)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    bw = im2bw(InputImage, 0.5);
    tmp = ~bw;
    %Get the background (background is black)
    YangImage = imfill(tmp, 'holes');
    %Get an inverted Image without background
    I = xor(YangImage , tmp);
    %Remove the circle in the Yang part and get Yin Part
    [L,num] = bwlabel( I );
    counts = sum(bsxfun(@eq,L(:),1:num));
    [~,ind] = max(counts);
    YangImage = (L==ind);
    
    YinImage = ~bw;
    [L W] = size(bw);
    y = round(L/2);
    counter = 1;
    MIN = 10000000;
    for x = 1:W
        if(bw(y, x) == 0)
            counter = counter + 1;
        else
            if(counter ~= 1)
                MIN = min(MIN, counter);
                counter = 1;
            end
        end
    end
    if(counter ~= 1)
        MIN = min(MIN, counter);
    end
    
    SE = strel('disk', MIN);
    YinImage = imerode(YinImage, SE);
    YinImage = imdilate(YinImage, SE);
    [L,num] = bwlabel( YinImage );
    counts = sum(bsxfun(@eq,L(:),1:num));
    [~,ind] = max(counts);
    YinImage = ~(L==ind);
end