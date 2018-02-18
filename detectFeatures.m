function Features = detectFeatures(img, width, height)
%img = imresize(img, [width, height]);
I = rgb2gray(img);

%Edge detection
[~, threshold] = edge(I, 'sobel');
fudgeFactor = .5;
BWs = edge(I,'sobel', threshold * fudgeFactor);

se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);
subplot(2,2,1), imshow(BWsdil);

BWdfill = imfill(BWsdil, 'holes');
subplot(2,2,2), imshow(BWdfill);

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
subplot(2,2,3), imshow(Final);

%Corner detection
C = detectHarrisFeatures(imbinarize(Final, 0.6));
C = C.selectStrongest(30);
subplot(2,2,4), imshow(img); hold on;
subplot(2,2,4), plot(C.Location(:,1), C.Location(:,2), 'r*');

Features = C.Location;