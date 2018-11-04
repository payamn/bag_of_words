
im = imread('../data/campus/sun_abpxvcuxhqldcvln.jpg');
im = double(im);
% filterBank = createFilterBank();
% filterResponses = extractFilterResponses(im, filterBank);
% figure;
% for i=1:5
%     for j=1:5
%         subplot(5, 5,  (i-1)*5+j);
%         max_f = filterResponses(:, :, (i-1)*5+j);
%         max_f = max(max_f(:))
%         imshow(filterResponses(:, :,  (i-1)*5+j)./max_f);
%     end
% end

num_pts = 500;
k = 0.05;
pts_random = getRandomPoints(im, num_pts);
pts_Harris = getHarrisPoints(im, num_pts, k);

figure;
imshow(im/max(im(:)));
hold on;
plot(pts_Harris(1, :), pts_Harris(2,:), '+g');

traintest = load('../data/traintest.mat');
train = traintest.train_imagenames; 
% getDictionary(train, 500, 300, 'random');
dictionary = load('../data/dictionary.mat');
words = getVisualWords(im, dictionary.filterBank, dictionary.dictionary);

imshow(label2rgb(words));