
imgLow = imread('dog.bmp');
imgHigh = imread('cat.bmp');

figure;
imshow(imgLow);
figure;
imshow(imgHigh);

imgLow2 = impyramid(imgLow, 'reduce');
imgLow2 = impyramid(imgLow2, 'reduce');
imgLow2 = impyramid(imgLow2, 'reduce');
imgLow2 = impyramid(imgLow2, 'expand');
imgLow2 = impyramid(imgLow2, 'expand');
imgLow2 = impyramid(imgLow2, 'expand');

imgHigh2 = impyramid(imgHigh, 'reduce');
imgHigh2 = impyramid(imgHigh2, 'reduce');
imgHigh2 = impyramid(imgHigh2, 'reduce');
imgHigh2 = impyramid(imgHigh2, 'expand');
imgHigh2 = impyramid(imgHigh2, 'expand');
imgHigh2 = impyramid(imgHigh2, 'expand');
imgHigh = imgHigh(:, 1:409,:);
imgHigh3 = imgHigh  - imgHigh2;

hybrid = 1.5*imgHigh3 + imgLow2;

figure;
imshow(hybrid);