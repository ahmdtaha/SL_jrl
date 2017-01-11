function [ accuracy_measure  ] = calculate_accuracy_measures2( inputimageOriginal,groundtruthOriginal)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

inputimage = inputimageOriginal(:) ./255;
groundtruth = groundtruthOriginal(:) ./255;
groundtruth(find(groundtruthOriginal == 128)) = 2;
fgroundtruth = groundtruth;fgroundtruth(groundtruth == 2) =0;
tgroundtruth = groundtruth;tgroundtruth(groundtruth == 2) =1;
width = size(inputimage ,2);
height = size(inputimage ,1);

total = width * height ;


postive = sum(groundtruth == 1);
unknown = sum(groundtruth == 2);
negative = total - postive - unknown;


truepositive = sum(inputimage & fgroundtruth);
falsepositive = sum(inputimage & ~tgroundtruth);
falsenegative = sum(~inputimage & fgroundtruth);
truenegative = sum(~inputimage & ~tgroundtruth);

truepositiverate = truepositive / postive;
falsepositiverate = falsepositive / negative;

Jaccard_index = truepositive/(truepositive +falsepositive+ falsenegative);
%Jaccard_index  = calculateJaccardIndex(inputimageOriginal,groundtruthOriginal)
recall = truepositive / (truepositive+falsenegative);
precision = truepositive /(truepositive+falsepositive);
Specificity = truenegative / (truenegative + falsepositive);
fmeasure = (2 * recall * precision) /(precision +recall);
%dice_index = (2*truepositive)/(truepositive +falsenegative + truepositive + falsepositive);
RI = (truepositive + truenegative) / (truepositive + truenegative + falsepositive+ falsenegative);
accuracy_measure = [truepositive,falsepositive,truenegative,falsenegative,recall,precision,Specificity,Jaccard_index,fmeasure,truepositiverate,falsepositiverate,RI];

end

