function result = Scale(image, scaleX, scaleY)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[H W L] = size(image) ;
newH = int32(double(H) * scaleY)+1;
newW = int32(double(W) * scaleX)+1;
result = uint8(zeros(newH, newW, L));
for	y=1:newH
	for x=1:newW
        y1=uint32(double(y)/scaleY);
        if(y1>H)
            y1=H;
        elseif(y1<1)
            y1=1;
        end
        x1=uint32(double(x)/scaleX);
        if(x1>W)
            x1=W;
        elseif(x1<1)
            x1=1;
        end
        result(y, x, :) = image(y1, x1, :);
    end
end
end

