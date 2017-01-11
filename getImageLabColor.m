function [ LABVector ] = getImageLabColor( rgbimage )
C = makecform('srgb2lab');
I_lab = applycform(rgbimage ,C);

L_vector  = I_lab(:,:,1);
L_vector  = L_vector  (:);
A_vector  = I_lab(:,:,2);
A_vector  = A_vector (:);
B_vector  = I_lab(:,:,3);
B_vector  = B_vector  (:);

L_vector  = normalize(double(L_vector));
A_vector  = normalize(double(A_vector));
B_vector  = normalize(double(B_vector));
LABVector = [L_vector,A_vector,B_vector];

end

