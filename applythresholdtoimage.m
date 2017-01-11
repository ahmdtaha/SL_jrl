function [ idm ] = applythresholdtoimage( f_efunc,threshold)


idm = ones(size(f_efunc))*1;

threshold = threshold/100.0;
idm(f_efunc <= threshold)=0;
idm(f_efunc >threshold )=1;


end

