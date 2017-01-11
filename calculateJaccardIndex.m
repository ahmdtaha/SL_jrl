function [Jaccard_index]= calculateJaccardIndex(img1,img2)

intersectImg = img1 & img2; 
unionImg = img1 | img2;
numerator = sum(intersectImg(:));
denomenator = sum(unionImg(:));
Jaccard_index = numerator/denomenator;

end