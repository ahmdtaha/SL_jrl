function [AccuracyRow,strokesJI] = scribble_image(path,markerImage,groundtruthPath,savePath,dataset_name,params)


[pathstr,name,ext] = fileparts(path) ;


%name
if(strcmp(dataset_name,'wzn_horses') == 1)
    gtPath = [groundtruthPath ,name,'.jpg'];
else
    gtPath = [groundtruthPath ,name,'.png'];
end
gtImage= imread(gtPath);




ratio = [512,1024,2048,4096];
percentile = 0;
count = 0;
strokesJI = [];

%tic
OriginalImage = imread(path);
gtImage = imresize(gtImage,[size(OriginalImage,1) size(OriginalImage,2)],'nearest');
width = size(OriginalImage,2);
height = size(OriginalImage,1);



while(count <= 0)
    [fillResult1] = colorandspatialaffinity( path,markerImage,ratio,percentile,params);
    %figure;imagesc(fillResult1);




    saveResult= uint8(fillResult1(:,:));
    saveResult=saveResult*255;
    prevLabels = markerImage;
    prevSeg = saveResult;

    %% Adjustment for weizmann horses ,weizmann 1 & 2 Objects dataset %%%%%%%%%%%%%%%%%
    if(strcmp(dataset_name,'wzn_horses') == 1)
       gtImage = imresize(gtImage,size(markerImage),'nearest');
       gtImage(gtImage<128) = 0;
       gtImage(gtImage>=128) = 255;
    elseif(strcmp(dataset_name,'bsd100') == 1)
        gtImage = gtImage(:,:,1) | gtImage(:,:,2) | gtImage(:,:,3);
        gtImage = gtImage *255;
        gtImage(gtImage<128) = 0;
        gtImage(gtImage>=128) = 255;
    end
    
    tmpsavepath = savePath;


    
    
    
    %%%%% end %%%%%%%%%%%%%%%%
    
    AccuracyRow = calculate_accuracy_measures2(fillResult1,gtImage);
    jIndex = AccuracyRow(8);
    
    
    gtMask = gtImage == 255; 
    unLabeledMask = gtImage == 128;
    % exclude unlabeld pixels from your score calculation
    segImageMask = fillResult1 ~= 0;
    segImageMask = segImageMask & ~unLabeledMask;
    
    intersection = segImageMask & gtMask;
    union = segImageMask | gtMask;
    visualizeFlag = 1;
    if (visualizeFlag)
        visImage = zeros(size(gtMask));
        visImage(intersection) = 1;
        visImage(xor(union, intersection) & gtMask) = 0.3;
        visImage(xor(union, intersection) & segImageMask) = 0.7;
%         imshow(visImage);
        %imagesc(visImage);
        rgb = zeros(size(OriginalImage));
        G = visImage==1;
        R = visImage==0.7;
        B = visImage==0.3;
        
        rgb(:,:,1)=R*255;
        rgb(:,:,2)=G*255;
        rgb(:,:,3)=B*255;
        
        C = imfuse(OriginalImage,rgb,'blend','Scaling','joint');
        figure;imshow(C);
        
        set(gca,'Units','normalized','Position',[0 0 1 1]);  %# Modify axes size
        set(gcf,'Units','pixels','Position',[0 0 width height]);  %# Modify figure size
        img = getframe(gcf);
        %imwrite(img.cdata, ['robot_user_result' int2str(count-1) '.png']);
        saveimagetopath(tmpsavepath ,[name '-result'],img.cdata,'.png');
        close all;
        %pause;
    end
    
    count = count +1;
    strokesJI=[strokesJI,jIndex ];
    
end;



end