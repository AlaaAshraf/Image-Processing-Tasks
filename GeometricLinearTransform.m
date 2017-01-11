function result = GeometricLinearTransform(Image , Transformation)
  
  [H, W, L] = size(Image);
  %Get a new Corners
  TopLeftCorner = Transformation * [0; 0; 1];
  TopRightCorner = Transformation * [W - 1; 0; 1];
  BottomLeftCorner = Transformation * [0; H - 1; 1];
  BottomRightCorner = Transformation * [W - 1; H - 1; 1];
  
  
  Corners = int16([TopLeftCorner, TopRightCorner, BottomLeftCorner, BottomRightCorner]);
  MaxXY = max(Corners, [], 2);
  MinXY = min(Corners, [], 2);
  WH =  MaxXY - MinXY;
  newW = WH(1) + 1;
  newH = WH(2) + 1;
  
  result = uint8(zeros(newH, newW, L));
  
  translationMatrix = [1.0, 0.0, double(-MinXY(1)); 0.0, 1.0, double(-MinXY(2)); 0.0, 0.0, 1.0];
  
  Transformation = translationMatrix * Transformation;
  
  inverseTransformation = Transformation^-1;
  
  for y = 1:newH
    for x = 1:newW
      newPosition = [x - 1; y - 1; 1];
      oldPosition = int16(inverseTransformation * double(newPosition));
      yy = oldPosition(2) + 1;
      xx = oldPosition(1) + 1;
      if ((yy > 0) && (yy < H + 1)) && (xx > 0) && (xx < W + 1)
        result(y, x, :) = Image(yy, xx, :);
      end
    end  
  end
  
end

