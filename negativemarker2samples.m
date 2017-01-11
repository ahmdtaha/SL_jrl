function [ negativeSample ] = negativemarker2samples( markerImage,height,width,ExpectedSampleCount)

negativeSample  =[];


    

ExpectedSampleCount = 7;
[B] = bwboundaries (reshape(double(markerImage==2),height,width));
for k = 1:length(B)
    boundary = B{k};
    total = size(boundary,1);
    step = (total/ExpectedSampleCount);

    negativeSample  = [negativeSample ;boundary(1:step:end,1),boundary(1:step:end,2)];
end


% extraNodes_Centroid = reshape(double(markerImage==6),height,width);
% [nX,nY] = ind2sub(size(extraNodes_Centroid),find(extraNodes_Centroid==1));
% nX = nX(1:2:end);
% nY = nY(1:2:end);
% negativeSample = [negativeSample; [nX,nY]];
% return;

extraNodes_Centroid = reshape(double(markerImage==6),height,width);
extraNodes_Centroid(extraNodes_Centroid == 6) =1;
if(sum(extraNodes_Centroid(:)) == 0)
    return;
end
% pivotPixels = bwulterode(extraNodes_Centroid);
% [centroids_X,centroids_Y] = ind2sub(size(pivotPixels),find(pivotPixels ==1));
% negativeSample = [negativeSample ;[centroids_X,centroids_Y]];

[B] = bwboundaries (extraNodes_Centroid);

ExpectedSampleCount = 4;
for k = 1:length(B)
    boundary = B{k};
    total = size(boundary,1);
    step = (total/ExpectedSampleCount);

    negativeSample  = [negativeSample ;boundary(1:step:end,1),boundary(1:step:end,2)];
end

return;
% ExpectedSampleCount = 4; 
% [B] = bwboundaries (extraNodes);
% for k = 1:length(B)
%     boundary = B{k};
%     total = size(boundary,1);
%     step = (total/ExpectedSampleCount);
% 
%     negativeSample  = [negativeSample ;boundary(1:step:end,1),boundary(1:step:end,2)];
% end

%extraNodes= reshape(double(markerImage==6),height,width);
ExpectedSampleCount = 1;

extraNodes_Centroid = reshape(double(markerImage==6),height,width);
extraNodes_Centroid(extraNodes_Centroid == 6) =1;
extraNodes_Centroid = bwlabel(extraNodes_Centroid);
s = regionprops(extraNodes_Centroid,'centroid');
centroids  = cat(1, s.Centroid);
centroids = floor(fliplr(centroids));
negativeSample = [negativeSample ;centroids];
%negativeSample
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
%     negativeSample  = [negativeSample ;boundary(1:step:end,1),boundary(1:step:end,2)];
% end

end




