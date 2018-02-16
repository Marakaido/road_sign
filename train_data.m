function [P, T] = train_data(folder)

files = dir(folder);
dirFlags = [files.isdir];
subFolders = files(dirFlags);

image_counter = 1;
class_counter = 1;
class_num = 62;
dims = 60;

for i = 1 : length(subFolders) - 2
   subfolder = strcat(folder, '/', subFolders(i+2).name);
   imgs = dir(strcat(subfolder, '*/*.ppm'));
   for k = 1 : length(imgs)
       path = strcat(subfolder, '/', imgs(k).name);
       img = imbinarize(rgb2gray(imresize(imread(path), [dims, dims])));
       P(:, image_counter) = img(:);
       
       t = zeros(class_num, 1);
       t(class_counter, 1) = 1;
       T(:, image_counter) = t;
       
       image_counter = image_counter + 1;
   end
   class_counter = class_counter + 1;
end

save train_data.mat P T