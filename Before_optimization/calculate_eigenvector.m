function [f_efunc,uu2,dd2,alpha2] = calculate_eigenvector( TotalVector,SIGMA_Percentage,NUM_EVECS,Ylabel,lambda )

indexes = find(Ylabel~=0);


[dd2,uu2] = eigenfunctions(TotalVector,SIGMA_Percentage,NUM_EVECS);
temp = zeros(size(uu2));
 %temp (:,:) = lambda* uu2(:,:);
 
temp(indexes,:)=uu2(indexes,:)*lambda;
 %tempx (:,:) = lambda * uu2(:,:);
 
 MatrixA = dd2 +uu2'*(temp);
 temp = zeros(size(Ylabel));
 
 temp (:,:) = lambda * Ylabel(:,:);

 MatrixB = uu2'*(temp);
 alpha2=pinv(MatrixA)*(MatrixB);
 f_efunc=uu2*alpha2;
 
 %tmp3 = (uu2 * alpha2 - Ylabel)';
 %tmp3 = tmp3(:,indexes)*lambda;
%smoothnesscost  = alpha2' * dd2 * alpha2 + tmp3 * (uu2 * alpha2 - Ylabel);

end

