function [ distbw ] = marker2bwdist( markerImage,height,width,bwdist_bandwidth)

    ypos = zeros(size(markerImage));
    yneg = zeros(size(markerImage));
    ypos(markerImage(:,1) == 1)=1;
    yneg(markerImage(:,1) == 2)=1;
    y = ypos - yneg;

    pos_distbw=bwdist(reshape(ypos,height,width) );
    pos_distbw=exp(-pos_distbw/(bwdist_bandwidth *mean(pos_distbw(:))));
    neg_bwdist= bwdist(reshape(yneg,height,width) );
    neg_bwdist=exp(-neg_bwdist/(bwdist_bandwidth *mean(neg_bwdist(:))));
    if (isnan(pos_distbw(1,1)))
        distbw=-neg_bwdist;
    else
        distbw=pos_distbw-neg_bwdist;
    end
    
    distbw = normalize(distbw(:));

end

