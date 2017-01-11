function [ image ] = smoothImage( image,hSize ,sigma)
H = fspecial('gaussian',[hSize hSize],sigma);
image= imfilter(image,H,'replicate');
end

