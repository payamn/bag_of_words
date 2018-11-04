function [points] = getHarrisPoints(I, alpha, k)
    % to grayscale

    if (ndims(I) == 3)
        I = rgb2gray( I./255);
    end
    I = imgaussfilt(I,.6);

    hs = fspecial('sobel');
    
%     Ix = imfilter(I, hs);
%     Iy = imfilter(I, hs');

    Ix = conv2(I, hs, 'same');
    Iy = conv2(I, hs', 'same');

    Ixy = Ix.*Iy;
    Ix2 = Ix .* Ix;
    Iy2 = Iy .* Iy;
    window = ones([7,7], 'double');
    
    Hxx = conv2(Ix2, window, 'same');

    
    Hyy = conv2(Iy2, window, 'same');
    Hxy = conv2(Ixy, window, 'same');
    det = (Hxx.* Hyy) - (Hxy .* Hxy );
    trace = (Hxx + Hyy);
    R = det - k* trace.^2;
    
    h_size = 5;
    h_size_h = round(h_size/2)
    h = ones([h_size, h_size], 'uint8');
    h(h_size_h, h_size_h) = 0;
    R = R.*(R>= imdilate(R, h));
    [~, index] = sort(R(:), 'descend');
    [points(2,:), points(1,:)] = ind2sub(size(I), index(1:alpha));
    


