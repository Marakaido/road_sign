function Features = detectFeatures(img, width, height)
img = imresize(img, [width, height]);
I = rgb2gray(img);

%Edge detection
[~, threshold] = edge(I, 'sobel');
fudgeFactor = .5;
BWs = edge(I,'sobel', threshold * fudgeFactor);

se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);

BWdfill = imfill(BWsdil, 'holes');

BWnobord = imclearborder(BWdfill, 4);

seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);

[x,y,z] = size(img);
Final = imcomplement(BWfinal);
Final = imfill(Final, [round(x/2), round(y/2)]);
Final = immultiply(Final, BWfinal);
%figure, imshow(Final), title('segmented');
Final = immultiply(Final,I);

%Corner detection
C = detectHarrisFeatures(imbinarize(Final, 0.6));
C = C.selectStrongest(30);
figure, imshow(Final); hold on;
plot(C.Location(:,1), C.Location(:,2), 'r*');

Features = C.Location;