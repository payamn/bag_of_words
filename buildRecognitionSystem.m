mydic = load('../data/dictionary.mat');
traintest = load('../data/traintest.mat');
trainLabels = traintest.train_labels;
trainFeatures = zeros(size(traintest.train_imagenames, 1), size(dictionary, 1));

for i=1:size(traintest.train_imagenames, 2)
    [name] =  traintest.train_imagenames(i);
    name = cell2mat(name);
    wordMap = load(strcat('../data/', name(1:end-4)));
    trainFeatures(i, :) = getImageFeatures(wordMap.wordMap, size(dictionary, 1));
end

save('../data/visionHarris.mat', 'dictionary', 'filterBank','trainFeatures', 'trainLabels');