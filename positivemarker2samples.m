function [ positiveSample ] = positivemarker2samples( markerImage,height,width,ExpectedSampleCount)

positiveSample  =[];


    

ExpectedSampleCount = 21;
[B] = bwboundaries (reshape(double(markerImage==1),height,width));
for k = 1:length(B)
    boundary = B{k};
    total = size(boundary,1);
    step = (total/ExpectedSampleCount);

    positiveSample  = [positiveSample ;boundary(1:step:end,1),boundary(1:step:end,2)];
end




% extraNodes_Centroid = reshape(double(markerImage==3),height,width);
% [nX,nY] = ind2sub(size(extraNodes_Centroid),find(extraNodes_Centroid==1));
% nX = nX(1:2:end);
% nY = nY(1:2:end);
% positiveSample = [positiveSample; [nX,nY]];
% return;

extraNodes_Centroid = reshape(double(markerImage==3),height,width);
extraNodes_Centroid(extraNodes_Centroid == 3) =1;
if(sum(extraNodes_Centroid(:)) == 0)
    return;
end
% pivotPixels = bwulterode(extraNodes_Centroid);
% [centroids_X,centroids_Y] = ind2sub(size(pivotPixels),find(pivotPixels ==1));
% positiveSample = [positiveSample ;[centroids_X,centroids_Y]];


[B] = bwboundaries (extraNodes_Centroid);

ExpectedSampleCount = 4;
for k = 1:length(B)
    boundary = B{k};
    total = size(boundary,1);
    step = (total/ExpectedSampleCount);

    positiveSample  = [positiveSample ;boundary(1:step:end,1),boundary(1:step:end,2)];
end

return;
extraNodes_Centroid = reshape(double(markerImage==3),height,width);
extraNodes_Centroid(extraNodes_Centroid == 3) =1;
extraNodes_Centroid = bwlabel(extraNodes_Centroid);
s = regionprops(extraNodes_Centroid,'centroid');
centroids  = cat(1, s.Centroid);
centroids = floor(fliplr(centroids));
positiveSample = [positiveSample ;centroids];
%positiveSample
% ExpectedSampleCount = 1;
% radius = 7;
% B = [];
% while (length(B) ==0 & radius > 1)
%     se = strel('disk',radius); 
%     extraNodes_erroded = imerode(extraNodes,se);
%     [B] = bwboundaries (extraNodes_erroded);
%     radius = radius-1;
% end
% 
% for k = 1:length(B)
%     boundary = B{k};
%     total = size(boundary,1);
%     step = (total/ExpectedSampleCount);
% 
%     positiveSample  = [positiveSample ;boundary(1:step:end,1),boundary(1:step:end,2)];
% end

end

