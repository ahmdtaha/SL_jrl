function [ fillResult] = colorandspatialaffinity( imagePath,markerImage,ratio,percentile)


OriginalImage = imread(imagePath);

width = size(OriginalImage,2);
height = size(OriginalImage,1);

%figure;imagesc(OriginalImage);
LV = computelocationvector(height,width);
markerImage = markerImage(:);
ypos = zeros(size(markerImage));
yneg = zeros(size(markerImage));
ypos(markerImage(:,1) == 1)=1; %% original foreground
ypos(markerImage(:,1) == 3)=1; %% robot foreground
yneg(markerImage(:,1) == 2)=1; %% original background
yneg(markerImage(:,1) == 6)=1; %% robot backgroudn
y = ypos - yneg;
%figure;imagesc(reshape(y,height,width));
%positiveSample = randsample(sampleIndexes,20,true,efunc_w);

[positiveSample,negativeSample] = markers2samples(markerImage,height,width);
positiveSample  = unique(positiveSample , 'rows');
negativeSample  = unique(negativeSample, 'rows');


positiveSampleLocation = LV(positiveSample,:);
negativeSampleLocation = LV(negativeSample,:);

%figure;imagesc(OriginalImage)
%hold on;
%scatter(positiveSampleLocation(:,2),positiveSampleLocation(:,1),'red')
%scatter(negativeSampleLocation(:,2),negativeSampleLocation(:,1),'green')
%hold off;


% distanceToPositive = dist2(LV,positiveSampleLocation);
% distanceToPositiveVariance = var(distanceToPositive);
% distanceToNegative = dist2(LV,negativeSampleLocation);
% distanceToNegativeVariance = var(distanceToNegative);
% 



tmpResult = computeDistances(double(OriginalImage),[positiveSampleLocation(:,1),positiveSampleLocation(:,2)]');
distanceToPositive1 =repmat(tmpResult(:),1,size(positiveSample,1));
distanceToPositiveVariance1 = var(distanceToPositive1);


tmpResult = computeDistances(double(OriginalImage),[negativeSampleLocation(:,1),negativeSampleLocation(:,2)]');    
distanceToNegative1 =repmat(tmpResult(:),1,size(negativeSample,1));
distanceToNegativeVariance1 = var(distanceToNegative1);

distanceToPositive = dist2(LV,positiveSampleLocation);
distanceToPositiveVariance = var(distanceToPositive);
distanceToNegative = dist2(LV,negativeSampleLocation);
distanceToNegativeVariance = var(distanceToNegative);

[VC,VGM,VGT,VGD] = get_channels(OriginalImage,[0,1.5,3,5]);
LABcolor = getImageLabColor(OriginalImage);


positiveSampleColor = VC(positiveSample,:);
negativeSampleColor = VC(negativeSample,:);

positiveSampleLABColor = LABcolor(positiveSample,:);
negativeSampleLABColor = LABcolor(negativeSample,:);


colorDistanceToPositive = dist2(VC,positiveSampleColor);
colorDistanceToNegative = dist2(VC,negativeSampleColor);

colorAffinityToPositive = exp(-colorDistanceToPositive);
colorAffinityToNegative = exp(-colorDistanceToNegative);

LABcolorDistanceToPositive = dist2(LABcolor,positiveSampleLABColor);
LABcolorDistanceToNegative = dist2(LABcolor,negativeSampleLABColor);

LABcolorAffinityToPositive = exp(-LABcolorDistanceToPositive);
LABcolorAffinityToNegative = exp(-LABcolorDistanceToNegative );



final_f_efunc  = zeros(width*height,1);

%ratio =[64,128,256,512];
%ratio =[64];

%[histArray] = localhist(OriginalImage);
relativeToPositiveV = [];
relativeToNegativeV = [];
%ICVVarianceRatio = [2^12,2^13,2^14,2^15];
%ICV = ICV / (-log(min(colorAffinityToPositive(:,1))));
%% when I divide ICV with a small digit , it was dominant, while when I divide it by big number , it was no longer dominant.


for i=1:1:length(ratio)




distanceAffinityToPositive = bsxfun(@rdivide,-distanceToPositive,(distanceToPositiveVariance ./ ratio (i))); 
distanceAffinityToPositive = exp(distanceAffinityToPositive);


distanceAffinityToNegative = bsxfun(@rdivide,-distanceToNegative,(distanceToNegativeVariance ./ ratio (i))); 
distanceAffinityToNegative = exp(distanceAffinityToNegative);

distanceAffinityToPositive1 = bsxfun(@rdivide,-distanceToPositive1,(distanceToPositiveVariance1 )); 
distanceAffinityToPositive1 = exp(distanceAffinityToPositive1);


distanceAffinityToNegative1 = bsxfun(@rdivide,-distanceToNegative1,(distanceToNegativeVariance1 )); 
distanceAffinityToNegative1 = exp(distanceAffinityToNegative1);


RGBrelativeToPositive = colorAffinityToPositive .* LABcolorAffinityToPositive  .* distanceAffinityToPositive .* distanceAffinityToPositive1;
RGBrelativeToNegative = colorAffinityToNegative .* LABcolorAffinityToNegative  .* distanceAffinityToNegative .* distanceAffinityToNegative1;


%LABrelativeToPositive = LABcolorAffinityToPositive .* distanceAffinityToPositive ;
%LABrelativeToNegative = LABcolorAffinityToNegative .* distanceAffinityToNegative ;

%relativeToPositiveV=[relativeToPositiveV,relativeToPositive ];
%relativeToNegativeV =[relativeToNegativeV,relativeToNegative];
%end



%relativeToPositive(find(isnan(relativeToPositive) ==1)) =1;
%relativeToNegative(find(isnan(relativeToNegative) ==1)) =1;


TotalVector = [RGBrelativeToPositive,RGBrelativeToNegative,LABcolor,VC];
isPCAEnable = 1;
if(isPCAEnable)
    [COEFF,SCORE]  = pca(TotalVector);
     %TotalVector = COEFF(:,1:80);
     TotalVector = COEFF;
end

NUM_EVECS = 100;
SIGMA_Percentage = 0.125;
lambda = 1000;
%f_efunc = calculate_eigenvector([RGBrelativeToPositive,RGBrelativeToNegative,LABcolor,VC],SIGMA_Percentage,NUM_EVECS,y,lambda); 
f_efunc = calculate_eigenvector(TotalVector,SIGMA_Percentage,NUM_EVECS,y,lambda); 
%final_f_efunc = final_f_efunc + f_efunc ;
final_f_efunc =[final_f_efunc ,f_efunc];
end;





%final_f_efunc = final_f_efunc ./ length(ratio);
final_f_efunc1 = max(final_f_efunc')';
%figure;imagesc(reshape(final_f_efunc1,height,width));
final_f_efunc2 = mean(final_f_efunc')';
%figure;imagesc(reshape(final_f_efunc2,height,width));
f_efunc = final_f_efunc2;
%figure;imagesc(reshape(f_efunc,height,width));
[ fillResult] = processf_efunc( f_efunc,markerImage, percentile,height,width);


%figure;imagesc(reshape(f_efunc,height,width));
%hold on;
%plot([positiveSampleLocation;negativeSampleLocation],'markersize',30,'o');
%plot(positiveSampleLocation(:,2),positiveSampleLocation(:,1),'o');
%plot(negativeSampleLocation(:,2),negativeSampleLocation(:,1),'+');
%hold off;



end

