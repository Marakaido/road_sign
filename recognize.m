function [R, V] = recognize(file, net)

t = im2double(imresize(imread(file), [60, 60]));
x = t(:);
V = net(x);
R = round(V);