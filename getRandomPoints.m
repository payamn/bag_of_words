function [points] = getRandomPoints(I, alpha)
   points = rand([2, alpha]);
   points(1, :) =  round(points(1,:) * size(I, 1));
   points(2, :) =  round(points(2,:) * size(I, 2));