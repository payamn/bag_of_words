function [dictionary] = getDictionary(imgPaths, alpha, K, method)
    filterBank = createFilterBank();    
    features = zeros([length(imgPaths)*alpha, length(filterBank)*3], 'double');
    k_harris = 0.05;

    for img_index=1:length(imgPaths)
        length(imgPaths)
        img_index
        im = imread(strcat('../data/', cell2mat(imgPaths(img_index))));
        im = double(im);
        %check number of dimentions
        if (ndims(im) ~= 3)
            im = cat(3, im, im, im);
        end

        if strcmpi(method, '‘harris’')
            pts = getHarrisPoints(im, alpha, k_harris);
        else
            pts = getRandomPoints(im, alpha);
        end
        
        % extract filter responses
        filterResponses = extractFilterResponses(im, filterBank);
        for pts_idx=1:size(pts, 2)
            pts_idx;
            x = pts(2, pts_idx);
            y = pts(1, pts_idx);
            if x ==0 || y ==0
                continue
            end
            feature = filterResponses(pts(1, pts_idx), pts(2, pts_idx), :);
            features(((img_index-1)*size(pts, 2)+ pts_idx), :) = feature(:)';
        end       
    end
    [~, dictionary] = kmeans(features, K, 'MaxIter',10000, 'EmptyAction', 'drop');
    save('../data/dictionaryHarris.mat', 'filterBank', 'dictionary');
