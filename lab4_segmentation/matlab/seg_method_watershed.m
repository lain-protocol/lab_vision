function [ my_segmentation ] = seg_method_watershed( img, number_of_clusters, feature_space )
%


%Filter by sobel
hy = fspecial('sobel');
hx = hy';

if strcmp(feature_space, 'rgb') || strcmp(feature_space, 'lab') || strcmp(feature_space, 'hsv')
    img = img;
    Iy = imfilter(double(img), hy, 'replicate');
    Ix = imfilter(double(img), hx, 'replicate');
    grad = (sqrt(Ix(:, :, 1).^2 + Iy(:, :, 1).^2) + sqrt(Ix(:, :, 2).^2 + Iy(:, :, 2).^2) + sqrt(Ix(:, :, 3).^2 + Iy(:, :, 3).^2))/3;

    
else
    %Add a component based on xy position
    chn = (img(:, :, 4).^2 + img(:, :, 5).^2);
    chn = uint8((chn / max(max(chn))) * 128) ;
    img = img(:, :, 1:3);
    Iy = imfilter(double(img), hy, 'replicate');
    Ix = imfilter(double(img), hx, 'replicate');
    grad = (double(chn) + (sqrt(Ix(:, :, 1).^2 + Iy(:, :, 1).^2) + sqrt(Ix(:, :, 2).^2 + Iy(:, :, 2).^2) + sqrt(Ix(:, :, 3).^2 + Iy(:, :, 3).^2)))/4;
    
end

%::Estimate min value to impose::
%reshape grad matrix to a vector
[sx sy] = size(grad);
Yv = reshape(grad,sx*sy,1);
per = prctile(Yv,50);

mi = min(min(grad));
mx = max(max(grad));

thresh = (((mi + mx)*0.18)+per)/2 ;



%Apply Gaussian Filter
G = fspecial('gaussian',[3 3],1.5);
%# Filter it
grad = imfilter(grad,G,'same');

%Impose minima
marker = imextendedmin(grad(:,:,1), thresh);
new_grad = imimposemin(grad(:,:), marker);
%figure; imshow(marker); imtool(grad);
%figure; imshow(my_segmentation); imtool(new_grad)

%Apply watershed
my_segmentation = watershed(new_grad);
%imtool(my_segmentation);






%TODO - C�mo interpretar el concepto de cluster en watersheds?
%este algor�tmo considera solo componentes conexas
%Idea: 
% - calcular promedio por componente conexo (crea un punto)
% - clustering sobre puntos generados en number_of_clusters

%h =  max(max(max(grad(:,:,1))));
%marker = imextendedmin(grad(:,:,1), h);
%new_grad = imimposemin(grad(:,:,1), marker);
%my_segmentation = watershed(new_grad);
%mx = max(max(max(my_segmentation)));

%while mx<= number_of_clusters
%    h=h-1;
%    marker = imextendedmin(grad(:,:,1), h);
%    new_grad = imimposemin(grad(:,:,1), marker);
%    my_segmentation = watershed(new_grad);  
%    mx = max(max(max(my_segmentation)));
%end






end

