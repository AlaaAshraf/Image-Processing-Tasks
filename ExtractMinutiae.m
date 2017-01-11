function [Endpoints, Bifurcations] = ExtractMinutiae(Image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[H, W, L] = size(Image);
%figure, imshow(Image), hold on;
Endpoints = zeros(2,0);
Bifurcations = Endpoints;
temp = ~im2bw(Image, 0.5);
temp = bwmorph(temp, 'thin', inf);
for y=2:H-1
    for x=2:W-1
        if (temp(y,x) == 1)
            temp2=[temp(y-1,x-1),temp(y-1,x),temp(y-1,x+1);
                temp(y,x-1),temp(y,x),temp(y,x+1);
                temp(y+1,x-1),temp(y+1,x),temp(y+1,x+1)];
            
            points = sum(sum(temp2));
            if(points==2)
                Endpoints=cat(2,Endpoints,[x;y]);
            elseif(points==4)
                Bifurcations=cat(2,Bifurcations,[x;y]);
            end
        end
    end
end
[M N] = size(Endpoints);
for x = 1: N
    X = Endpoints(1, x);
    Y = Endpoints(2, x);
    Image(Y, X, :) = [255 0 0];
    Image(Y, X - 1, :) = [255 0 0];
    Image(Y, X + 1, :) = [255 0 0];
    Image(Y - 1, X, :) = [255 0 0];
    Image(Y + 1, X, :) = [255 0 0];
    Image(Y - 1, X - 1, :) = [255 0 0];
    Image(Y + 1, X + 1, :) = [255 0 0];
    Image(Y- 1, X + 1, :) = [255 0 0];
    Image(Y+ 1, X - 1, :) = [255 0 0];
end
[M N] = size(Bifurcations);
for x = 1: N
    X = Bifurcations(1, x);
    Y = Bifurcations(2, x);
    Image(Y, X, :) = [0 0 255];
    Image(Y, X - 1, :) = [0 0 255];
    Image(Y, X + 1, :) = [0 0 255];
    Image(Y - 1, X, :) = [0 0 255];
    Image(Y + 1, X, :) = [0 0 255];
    Image(Y - 1, X - 1, :) = [0 0 255];
    Image(Y + 1, X + 1, :) = [0 0 255];
    Image(Y- 1, X + 1, :) = [0 0 255];
    Image(Y+ 1, X - 1, :) = [0 0 255];
end

figure, imshow(Image);
end

