function [wordMap] = getVisualWords(I, filterBank, dictionary)
    [w, h, c]= size(I);

    filterResponses=extractFilterResponses(I,filterBank);
    sizeimp=w*h;
    filterRespon2DIMG=reshape(filterResponses,[sizeimp,60]);

    [~,f]= pdist2(dictionary,filterRespon2DIMG,'cosine', 'SMALLEST', 1);
    f=f';
    f=reshape(f,w,h);    
    wordMap=f;
end
