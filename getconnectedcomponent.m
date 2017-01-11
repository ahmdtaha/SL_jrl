function [ idmSmoothed ] = getconnectedcomponent( ylabel, idmSmoothed)

fgBrushMask=(ylabel==1);
[fgL,fgNum]=bwlabel(fgBrushMask);
%% hard constraints
idmSmoothed(ylabel==1) =1;
idmSmoothed(ylabel==-1) =0;
% 
segL=bwlabel(idmSmoothed);

for i=1:fgNum
    brIndex=find(fgL==i,1);
    segLabel=segL(brIndex);
    if(segLabel~=0)
      idmSmoothed(:)=0;
      idmSmoothed(segL==segLabel)=true;
    end
end


end

