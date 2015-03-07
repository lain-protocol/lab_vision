
imgLow = imread('imgHomeworkA.png');
imgHigh = imread('imgHomeworkB.png');

figure;
imshow(imgLow);
figure;
imshow(imgHigh);

imgLow2 = impyramid(imgLow, 'reduce');
imgLow2 = impyramid(imgLow2, 'reduce');
imgLow2 = impyramid(imgLow2, 'reduce');
imgLow2 = impyramid(imgLow2, 'reduce');
imgLow2 = impyramid(imgLow2, 'expand');
imgLow2 = impyramid(imgLow2, 'expand');
imgLow2 = impyramid(imgLow2, 'expand');
imgLow2 = impyramid(imgLow2, 'expand');

imgHigh2 = impyramid(imgHigh, 'reduce');
imgHigh2 = impyramid(imgHigh2, 'reduce');
imgHigh2 = impyramid(imgHigh2, 'reduce');
imgHigh2 = impyramid(imgHigh2, 'reduce');
imgHigh2 = impyramid(imgHigh2, 'expand');
imgHigh2 = impyramid(imgHigh2, 'expand');
imgHigh2 = impyramid(imgHigh2, 'expand');
imgHigh2 = impyramid(imgHigh2, 'expand');
imgHigh = imgHigh(1:497, 1:497,:);
imgHigh3 = imgHigh  - imgHigh2;

hybrid = 1.4*imgHigh3 + imgLow2;
figure;
imshow(hybrid);

%Fourier-DCT transforms
figure;
F = fft2(imgLow);
F = fftshift(F);
F = abs(F);
F = log(F+1);
F = mat2gray(F);
subplot(2,5,1)
imshow(F,[]), colormap(jet(64)), colorbar;
title('FFT - Imagen 1 (Low)');

C = dct2(rgb2gray(imgLow));
C = abs(C);
C = log(C+1);
subplot(2,5,6)
imshow(C,[]), colormap(jet(64)), colorbar;
title('DCT - Imagen 1 (Low)');

F = fft2(imgLow2);
F = fftshift(F);
F = abs(F);
F = log(F+1);
F = mat2gray(F);
subplot(2,5,2)
imshow(F,[]), colormap(jet(64)), colorbar;
title('FFT - Imagen 1 - Filter (Low)');

C = dct2(rgb2gray(imgLow2));
C = abs(C);
C = log(C+1);
subplot(2,5,7)
imshow(C,[]), colormap(jet(64)), colorbar;
title('DCT - Imagen 1 - Filter (Low)');



F = fft2(imgHigh);
F = fftshift(F);
F = abs(F);
F = log(F+1);
F = mat2gray(F);
subplot(2,5,3)
imshow(F,[]), colormap(jet(64)), colorbar;
title('FFT - Imagen 2 (High)');

C = dct2(rgb2gray(imgHigh));
C = abs(C);
C = log(C+1);
subplot(2,5,8)
imshow(C,[]), colormap(jet(64)), colorbar;
title('DCT - Imagen 2 (High)');

F = fft2(imgHigh3);
F = fftshift(F);
F = abs(F);
F = log(F+1);
F = mat2gray(F);
subplot(2,5,4)
imshow(F,[]), colormap(jet(64)), colorbar;
title('FFT - Imagen 2 - Filter (High)');

C = dct2(rgb2gray(imgHigh3));
C = abs(C);
C = log(C+1);
subplot(2,5,9)
imshow(C,[]), colormap(jet(64)), colorbar;
title('DCT - Imagen 2 - Filter (High)');

F = fft2(hybrid);
F = fftshift(F);
F = abs(F);
F = log(F+1);
F = mat2gray(F);
subplot(2,5,5)
imshow(F,[]), colormap(jet(64)), colorbar;
title('FFT - Hibrida');

C = dct2(rgb2gray(hybrid));
C = abs(C);
C = log(C+1);
subplot(2,5,10)
imshow(C,[]), colormap(jet(64)), colorbar;
title('DCT - Hibrida');

figure;
%subplot(3,2,1);
figure; imshow(hybrid);
hybrid = impyramid(hybrid, 'reduce');
%subplot(3,2,2);
figure; imshow(hybrid);
hybrid = impyramid(hybrid, 'reduce');
%subplot(3,2,3);
figure; imshow(hybrid);
hybrid = impyramid(hybrid, 'reduce');
%subplot(3,2,4);
figure; imshow(hybrid);
hybrid = impyramid(hybrid, 'reduce');
%subplot(3,2,5);
figure; imshow(hybrid);
hybrid = impyramid(hybrid, 'reduce');


