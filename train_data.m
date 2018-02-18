function [P, T] = train_data(folder, saveFile)

files = dir(folder);
dirFlags = [files.isdir];
subFolders = files(dirFlags);

image_counter = 1;
class_counter = 1;
class_num = 62;
dims = 80;

for i = 1 : length(subFolders) - 2
   subfolder = strcat(folder, '/', subFolders(i+2).name);
   imgs = dir(strcat(subfolder, '*/*.ppm'));
   for k = 1 : length(imgs)
       path = strcat(subfolder, '/', imgs(k).name);
       img = imread(path);
       data = detectFeatures(img, dims, dims);
       data = reshape(data, 1, []);
       data = data / 80;
       data(60) = 0;
       P(:, image_counter) = data;
       
       t = zeros(class_num, 1);
       t(class_counter, 1) = 1;
       T(:, image_counter) = t;
       
       image_counter = image_counter + 1;
   end
   class_counter = class_counter + 1;
end

save(saveFile, 'P', 'T')