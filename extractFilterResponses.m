function [filterResponses] = extractFilterResponses(I, filterBank)

    if(size(I,3)==1)
        I = repmat(img, [1 1 3]);
    end
    
    lab_image = RGB2Lab(I(:, :, 1), I(:, :, 2), I(:, :, 3));
    filterResponses = zeros(size(I, 1), size(I, 2), size(filterBank,1) * 3, 'double');
    for i=1:length(filterBank)
        filter = filterBank{i};
        for index = 1: 3
            imnew =  imfilter(I(:,:,index), filter);
            filterResponses(:, :, (i-1)*3 + index) = imnew;
%             imshow(filterResponses(:, :, (i-1)*3 + index))
        end
    end


