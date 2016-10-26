function [Endpoints Bifurcations] = ExtractMinutiae(Image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[H, W, L] = size(Image);
temp = ones(H,W);
Endpoint = zeros(H,W);
Bifurcations = zeros(H,W);
for y=1:H
    for x=1:W
        if Image(y,x,1)>100&&Image(y,x,2)>100&&Image(y,x,3)>100
            temp(y,x)=0;
        end
    end
end

mask = [1,1,1; 1,0,1; 1,1,1];
for y=2:H-1
    for x=2:W-1
        if temp(y,x)==1
            temp2=[temp(y-1,x-1),temp(y-1,x),temp(y-1,x+1);temp(y,x-1),temp(y,x),temp(y,x+1);temp(y+1,x-1),temp(y+1,x),temp(y+1,x+1)];
            temp2=temp2&mask;
            temp2 = sum(temp2);
            temp2=sum(temp2);
            if(temp2==1)
                Endpoints(y,x)=1;
            end
            if(temp2==3)
                Bifurcations(y,x)=1;
            end
        end
    end
end

end

