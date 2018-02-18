function [R, V, P, Category] = recognize(file, net)

img = imread(file);
data = detectFeatures(img, 80, 80);
data = reshape(data, 1, []);
data(60) = 0;
x = data(:);
V = net(x);

R = zeros(62, 1);
[~, index] = min(abs(V-1));
R(index) = 1;

P = zeros(62, 2);
[P(:, 2), P(:, 1)] = sort(V,'descend');

Category = P(1, 1)-1;