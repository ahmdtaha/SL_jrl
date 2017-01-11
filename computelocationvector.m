function [ Location_vector ] = computelocationvector( height, width)
Location_vector = [];
%%%%%%%%%%%%%%% calculating location Vector V1 %%%%%%%%%%%%%%% 
n = [1:height]';
tmp = repmat(n,1,width);
Location_vector(:,1) = tmp(:);
%Location_vector(:,1) = normalize(tmp(:));
%Location_vector(:,1) = (tmp(:));

z= 1:width;
tmp = repmat(z,height,1);
Location_vector(:,2) = tmp(:);
%Location_vector(:,2) = normalize(tmp(:));

end

