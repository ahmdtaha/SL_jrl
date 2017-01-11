function [ fillResult] = processf_efunc( f_efunc,y, percentile,height,width)

 if(percentile == -1)
    [m_percentile]= getMinPercentile(f_efunc);
    idm= getPercentile( f_efunc,m_percentile );
 else
    m_percentile = percentile;
    %idm= getPercentile( f_efunc,m_percentile );
    idm = applythresholdtoimage(f_efunc,m_percentile);
 end
 
 idm = reshape(idm ,height,width);
idmSmoothed = smoothImage(idm ,2,0.5);
idmSmoothed(idmSmoothed>=0.5)=1;
idmSmoothed(idmSmoothed< 0.5)=0;
idmSmoothed(y==1)=1;
idmSmoothed(y==3)=1;


%% Code that gets the largest connected component
FG = zeros(size(y));FG(y==1)=1;
%idmSmoothedFG=getconnectedcomponent(reshape(FG,height,width),idmSmoothed);
%% end

%% Code that gets the largest two connected component
markerL = bwlabel(reshape(y,height,width));
labels = unique(markerL);
connectedSeg = zeros(height,width);

for i=1:length(labels)
    maj = mean(y(find(markerL == i)));

    if(maj==1 | maj==3)
        tmp = zeros(height,width);
        tmp(markerL == i) = 1;
        tmp1 = connectedSeg+ getconnectedcomponent(tmp,idmSmoothed);
        connectedSeg = min(1,tmp1);
        %connectedSeg = connectedSeg+ getconnectedcomponent(tmp,idmSmoothed);
    
        
    end
    
end

idmSmoothedFG = connectedSeg;
idmSmoothedFGFinal = imfill(idmSmoothedFG);
%idmSmoothedFGFinal = idmSmoothedFG;

idmSmoothedFGFinal(y==2)=0;
idmSmoothedFGFinal(y==6)=0;
idmSmoothed(y==2)=0;
idmSmoothed(y==6)=0;
validatePos = (idmSmoothedFGFinal(y == 1) == 1);
if(sum(~validatePos) > 0)
    fprintf('something is wrong');
end

validatePos = (idmSmoothedFGFinal(y == 3) == 1);
if(sum(~validatePos) > 0)
    fprintf('something is wrong');
end

validatePos = (idmSmoothedFGFinal(y == 2) == 0);
if(sum(~validatePos) > 0)
    fprintf('something is wrong');
end
validatePos = (idmSmoothedFGFinal(y == 6) == 0);
if(sum(~validatePos) > 0)
    fprintf('something is wrong');
end

connectedSeg = idmSmoothedFGFinal;
%figure;imagesc(connectedSeg);

for i=1:length(labels)
    maj = mean(y(find(markerL == i)));
    
    if(maj==2 | maj==6)
    tmp = zeros(height,width);
    tmp(markerL == i) = 1;
    tmp1= connectedSeg - getconnectedcomponent(tmp,~idmSmoothed);
    connectedSeg = max(0,tmp1);     
    end
    
end
    
idmSmoothedFG = connectedSeg;

% segL=bwlabel(idmSmoothed);
% regions = regionprops(segL,'Area');
% areas= cat(1, regions.Area);
% [sorted,Indexes] = sort(areas,'descend');
% 
% idmSmoothedFG = zeros(size(idmSmoothed));
% noOfRegions = 1;
% 
% while(noOfRegions <=3)
%     if(length(sorted) >= noOfRegions)
%         if(sum(y(segL(:,:)==Indexes(noOfRegions ))))
%             idmSmoothedFG(segL(:,:)==Indexes(noOfRegions))=1;
%         end;
%     end;
%     noOfRegions = noOfRegions + 1;
% end


%idmSmoothedFG(segL(:,:)==Indexes(2))=1;
%end
%% end

%idmSmoothedFG=idmSmoothed;

%idmSmoothedFGFinal = imfill(idmSmoothedFG);
idmSmoothedFGFinal = idmSmoothedFG;

validatePos = (idmSmoothedFGFinal(y == 1) == 1);
if(sum(~validatePos) > 0)
    fprintf('something is wrong');
end
validatePos = (idmSmoothedFGFinal(y == 3) == 1);
if(sum(~validatePos) > 0)
    fprintf('something is wrong');
end

validatePos = (idmSmoothedFGFinal(y == 2) == 0);
if(sum(~validatePos) > 0)
    fprintf('something is wrong');
end
validatePos = (idmSmoothedFGFinal(y == 6) == 0);
if(sum(~validatePos) > 0)
    fprintf('something is wrong');
end




saveResult= uint8(idmSmoothedFGFinal(:,:));
fillResult=saveResult*255;
validatePos = (fillResult(y == 1) == 255);
if(sum(~validatePos) > 0)
    fprintf('something is wrong');
end


end

