function [ result ] = AddTwoImages( I1, I2, fract )

imageSize = size(I1);
result = zeros(imageSize);
I2=imresize(I2, [imageSize(1), imageSize(2)]);
result = uint8(I1.*fract + (1-fract).*I2);
end

