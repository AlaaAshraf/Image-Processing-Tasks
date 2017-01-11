function result = Brightness(image, channelName, offset)
    result = image;
    [H W L] = size(image);
    if (L == 1)
        return;
    end

    if (strcmp(channelName, 'R'))
        result(:,:,1) = result(:,:,1) + offset;
    elseif (strcmp(channelName, 'G'))
        result(:,:,2) = result(:,:,2) + offset;
    elseif (strcmp(channelName, 'B'))
        result(:,:,3) = result(:,:,3) + offset;
    end
end