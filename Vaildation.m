function [ N ] = Vaildation( mask )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    %check digonals
    digonal1 = mask(1,1) + mask(2,2) + mask(3,3);
    digonal2 = mask(1,3) + mask(2,2) + mask(3,1);

    tmpX = sum(mask);
    tmpY = sum(mask.');
    N = 0;
    for y = 1: 3
        if(tmpY(y) == 3)
            continue;
        end
        for x = 1: 3
            counter = 0;
            %check columns
            if(tmpX(x) == 3)
                continue;
            end
            if(digonal1 == 3 && x == y)
                continue;
            end
            if(digonal2 == 3 && ((x ==3 &&y == 1  ) || (x ==2 &&y == 2) || (x ==1 &&y == 3)))
                continue;
            end
            
            if(mask(y,x) == 1)
                if(y == 2 && x == 2)
                    continue;
                end
                if(y-1 > 0 && x-1 > 1)
                counter = counter + mask(y-1, x-1);
                end
                if(y-1 > 0)
                counter = counter + mask(y-1, x);
                end
                if(y-1 > 0 && x+1 < 4)
                counter = counter + mask(y-1, x+1);
                end
                if(y+1 < 4 && x+1 < 4)
                counter = counter + mask(y+1, x+1);
                end
                if(y+1 < 4)  
                counter = counter + mask(y+1, x);
                end
                if(y+1 < 4 && x-1 > 0)
                counter = counter + mask(y+1, x-1);
                end
                if(x-1 > 0)
                counter = counter + mask(y, x-1);
                end
                if(x+1 < 4)
                counter = counter + mask(y, x+1);
                end
                if(counter == 1)
                    N = N + 1;
                end
            end
        end
    end

end

