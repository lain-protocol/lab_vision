rgb_image = imread('images\2018.jpg');
my_segmentation = segment_by_clustering( rgb_image, 'hsvxy', 'watershed', 10);
figure;
imshow(rgb_image);
figure
colormap colorcube;
imshow(my_segmentation, colormap);
