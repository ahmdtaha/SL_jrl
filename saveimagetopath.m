function  saveimagetopath( path,name,im,ext)


if ~exist(path, 'dir')
  mkdir(path);
end
imwrite(im,[path name ext]);

end

