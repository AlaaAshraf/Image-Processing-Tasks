function result = Rotate(image, angle)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[H W L] = size(image) ;
newH=max([W H]);
newW=newH;
midH=ceil((H+1)/2);
midW=ceil((W+1)/2);
result = uint8(zeros(H, W, L));
for y=1:H
    for x=1:W
        y2=-x*sind(angle)+y*cosd(angle);
        y2=round(y2);
        x2=x*cosd(angle)+y*sind(angle);
        x2=round(x2);
        if(x2>=1)&&(y2>=1)&&(x2<=W)&&(y2<=H)
        result(y2, x2, :)=image(y,x,:);
        end
    end
end
end

