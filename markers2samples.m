function [ positiveSample,negativeSample ] = markers2samples( markerImage,height,width,params )

positiveMarkerImage= zeros(size(markerImage));positiveMarkerImage(markerImage ==1)= 1;positiveMarkerImage(markerImage ==3)= 3;
negativeMarkerImage= zeros(size(markerImage));negativeMarkerImage(markerImage ==2)= 2;negativeMarkerImage(markerImage ==6)= 6;
%figure;imagesc(markerImage);
ExpectedSampleCount = params.NUM_PIVOTS-1;
 negativeSample = negativemarker2samples(negativeMarkerImage,height,width,ExpectedSampleCount);
 if(~isempty(negativeSample ) )
 negativeSample = sub2ind([height,width],negativeSample(:,1),negativeSample(:,2));
  end
 
 
  positiveSample = positivemarker2samples(positiveMarkerImage,height,width,ExpectedSampleCount);
  if(~isempty(positiveSample))
  positiveSample = sub2ind([height,width],positiveSample(:,1),positiveSample(:,2));
  end
end


