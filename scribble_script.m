%clear all;
close all;

addpath(genpath('code'));
addpath(genpath('MatlabFns'));

[keynames,values]=textread('config_geo.txt','%s=%s');

rootPath = char(values(1));
annotationPath_3 = char(values(2));
savePath = char(values(3));
groundtruthPath = char(values(4));
dataset_name = char(values(5));

params = {};
params.NUM_EIG = 100;
params.NUM_PIVOTS = 21;


%% Use these lines to list all files.
filesPath = [rootPath '*.jpg'];
filenames = fuf(filesPath ,'detail'); 
filesPath = [rootPath '*.bmp'];
filenames = [filenames;fuf(filesPath ,'detail')]; 
filesPath = [rootPath '*.png'];
filenames = [filenames;fuf(filesPath ,'detail')]; 


%% Use these lines if you want to test certain image.
% filesPath = [rootPath '21077.jpg'];
% filenames = fuf(filesPath ,'detail'); 


filenames_annotations = [];
accuracies = [];
strokesJIs = [];
fnames =cell(length(filenames),1);
tic

%for i=1:length(filenames)
for i=1:length(filenames)
    [pathstr,name,ext] = fileparts(filenames{i}) ;
        
    
    filenames_annotations =[annotationPath_3,name,'-anno','.png'];
    
    markerImage3 = imread(filenames_annotations);

    
    [accuracy,strokesJI] = scribble_image(filenames{i},markerImage3,groundtruthPath,savePath,dataset_name,params);
    fnames{i} = name;
    strokesJIs = [strokesJIs;strokesJI];
    accuracies = [accuracies;accuracy]; 
    current = mean(accuracies(1:i,8));
    fprintf('%s => %f :: , mean so far %f\n', name,strokesJI,current );
    %save('workspace_ru');
end
toc
