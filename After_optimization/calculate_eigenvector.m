function [f_efunc,uu2,dd2,alpha2] = calculate_eigenvector( TotalVector,SIGMA_Percentage,NUM_EVECS,Ylabel,lambda )

indexes = Ylabel~=0;



%[dd2,uu2] = eigenfunctions_mex(TotalVector,SIGMA_Percentage,NUM_EVECS,0.1);
start = tic;
[dd2,uu2] = eigenfunctions(TotalVector,SIGMA_Percentage,NUM_EVECS,0.1);
totalTime = toc(start);


%disp(['eigenfunctions method call' num2str(totalTime)]);

 %temp (:,:) = lambda* uu2(:,:);

%tic
%temp = (zeros(size(uu2)));
%temp(indexes,:)=uu2(indexes,:)*lambda;
%MatrixA1 = dd2 +uu2'*(temp);
 %mat=toc
 
 tic
 MatrixA = dd2 +uu2'*multipleRow_orig(double(uu2),size(uu2,1),size(uu2,2),1000,size(find(indexes==1),1),double(find(indexes==1)));
 %MatrixA = dd2 + multipleRowAndMultiMatrix(double(uu2),size(uu2,1),size(uu2,2),1000,size(find(indexes==1),1),double(find(indexes==1)),double(uu2'));
 %[~,C]=multipleRow(double(uu2),size(uu2,1),size(uu2,2),1000,size(find(indexes==1),1),double(find(indexes==1)),double(uu2'));
 %MatrixA = dd2 +C;
 %diff = MatrixA - MatrixA1;
 %cost = size(unique(diff));
 toc
 
%  tic
%  MatrixA = dd2 +matrixMultiply(uu2',temp);
%  toc
%  
% MatrixA = dd2 +uu2'*((uu2(indexes,:)*lambda));
 
 %clear temp;
 
 tic
 %temp = zeros(size(Ylabel));
 %temp (:,:) = lambda * Ylabel(:,:);
 MatrixB = uu2'*(lambda * Ylabel(:,:)); %% this temp is not the same as the previous temp in MatrixA operation
 toc
 
 tic
 alpha2=matrixDivide(MatrixA,MatrixB);
 toc
 %alpha2=calculate_pinv_mex300(MatrixA)*(MatrixB);
 %alpha2=(MatrixA)\(MatrixB);
 
 f_efunc=uu2*alpha2;
 
 %clear uu2;
 %clear alpha2;
 %clear MatrixA;
 %clear MatrixB;
 %clear indexes;
 %clear temp;
 
 %tmp3 = (uu2 * alpha2 - Ylabel)';
 %tmp3 = tmp3(:,indexes)*lambda;
%smoothnesscost  = alpha2' * dd2 * alpha2 + tmp3 * (uu2 * alpha2 - Ylabel);

end

