function [FeatureColor,FeatureGM,FeatureTex,FeatureGD] = get_channels(RGBImage,S)


R_vector  = RGBImage(:,:,1);
R_vector  = R_vector (:);
G_vector  = RGBImage(:,:,2);
G_vector  = G_vector (:);
B_vector  = RGBImage(:,:,3);
B_vector  = B_vector (:);

R_vector  = normalize(double(R_vector));
G_vector  = normalize(double(G_vector));
B_vector  = normalize(double(B_vector));

%% Apply smoothing on the Image before I %%
FeatureGM=[];
FeatureTex=[];
FeatureColor=[];
FeatureGD=[];
I = int32(rgb2gray(RGBImage));
pChns=chnsCompute();
pChns.shrink=1;
pChns.pGradHist.nOrients=8;
chns=chnsCompute(RGBImage,pChns);
count=1;
for is=S
    if (is==0)
        glcm3 = rangefilt(I,ones(3,3));
        glcm5 = rangefilt(I,ones(5,5));
        glcm7 = rangefilt(I,ones(7, 7));
        glcm9 = rangefilt(I,ones(9,9));
        glcm3= normalize(double(glcm3(:)));
        glcm5= normalize(double(glcm5(:)));
        glcm7= normalize(double(glcm7(:)));
        glcm9= normalize(double(glcm9(:)));
        Feature{count}{1}=[glcm3,glcm7];
        FeatureTex=[FeatureTex,Feature{count}{1}];
        [Gx ,Gy] = gradient2(single(I)/255);
        GMag_SM0=sqrt(Gx.*Gx+Gy.*Gy);
        Feature{count}{2}=normalize(GMag_SM0(:));
        FeatureGM=[FeatureGM,Feature{count}{2}];
        chns=chnsCompute(RGBImage,pChns);
        GDir = chns.data{3};
        GDir=reshape(GDir,[],8);
        for i=1:8
            GDir(:,i)=normalize(GDir(:,i));
        end
        Feature{count}{3}=GDir;
        FeatureGD=[FeatureGD,Feature{count}{3}];
        
        Color= chns.data{1};
        for i=1:3
            Color(:,i)=normalize(Color(:,i));
        end
        Color=reshape(Color,[],3);
        Feature{count}{4}=Color;
        FeatureColor=[FeatureColor,Feature{count}{4}];    
        
        count=count+1;
    else
        smoothingFilter= fspecial('gaussian',[11 11], is);
        I_sm= imfilter(I , smoothingFilter, 'symmetric');

        glcm3 = rangefilt(I_sm,ones(3,3));
        glcm5 = rangefilt(I_sm,ones(5,5));
        glcm7 = rangefilt(I_sm,ones(7, 7));
        glcm9 = rangefilt(I_sm,ones(9,9));
        glcm3= normalize(double(glcm3(:)));
        glcm5= normalize(double(glcm5(:)));
        glcm7= normalize(double(glcm7(:)));
        glcm9= normalize(double(glcm9(:)));
        Feature{count}{1}=[glcm3,glcm7];
        FeatureTex=[FeatureTex,Feature{count}{1}];

        [Gx ,Gy] = gradient2(single(I_sm)/255);
        GMag=sqrt(Gx.*Gx+Gy.*Gy);

        Feature{count}{2}=normalize(GMag(:));
        FeatureGM=[FeatureGM,Feature{count}{2}];
        chns=chnsCompute(RGBImage,pChns);
        GDir = chns.data{3};
        GDir=reshape(GDir,[],8);
        for i=1:8
            GDir(:,i)=normalize(GDir(:,i));
        end
        Feature{count}{3}=GDir;
        FeatureGD=[FeatureGD,Feature{count}{3}];
        count=count+1;
    end
end
 
%Featall=cat(1,Feature(:));
%Featall_ch= cat(2,Featall{:});
%FeaturesCat=cat(2,Featall_ch{:});
%FeatureColor=FeaturesCat(:,12:14);
%FeatureGM=FeaturesCat(:,[5,19,30,41,52]);
%FeatureTex=FeaturesCat(:,[1:4 15:18 26:29 37:40 48:51]);
%FeatureGD=FeaturesCat(:,[6:11 20:25 31:36 42:47 53:58]);
%Features=[FeatureColor,FeatureGM,FeatureTex,FeatureGD];
end

