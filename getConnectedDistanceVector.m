function [ connectedDistanceVector ] = getConnectedDistanceVector( imRgb)

connectedDistanceVector = [];
[height width dim] = size(imRgb);
for row=1:1:height
    for col=1:1:width
        row
        connectedDistanceVector = [connectedDistanceVector;calcuateDistanceConnected(col,row,imRgb,height,width)];
    end;
end;

end

