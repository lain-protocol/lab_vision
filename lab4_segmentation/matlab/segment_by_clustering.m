function my_segmentation = segment_by_clustering( rgb_image, feature_space, clustering_method, number_of_clusters)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


img = zeros(1,1);
if strcmp(feature_space,'lab')
    %Transform to color space
    colorTransform = makecform('srgb2lab');
    img = applycform(rgb_image, colorTransform);
elseif strcmp(feature_space,'rgb')
    img = rgb_image;
elseif strcmp(feature_space,'hsv')
    img =  rgb2hsv(rgb_image);    
end

%'rgb'    , 'lab', 'hsv', 'rgb+xy', 'lab+xy', 'hsv+xy'


%put values on an array
if strcmp(clustering_method,'hierarchical')
    imgl = imresize(img, 0.2);
else 
    imgl = img;
end

[da, db, dc] = size(img);
[dal, dbl, dcl] = size(imgl);
X = double(reshape(img,da*db,dc));
Xl = double(reshape(imgl,dal*dbl,dc));
%X = [randn(100,2) + ones(100,2); randn(100,2) - ones(100,2)];

if strcmp(clustering_method,'k-means')
    %Perform clustering & adjust result as a matrix again
    [idx, ctrs] = kmeans(X, number_of_clusters);
    my_segmentation = reshape(idx,da,db);

elseif strcmp(clustering_method,'gmm')
    %Perform fit, clustering & adjust result as a matrix again
    gm = gmdistribution.fit(X,number_of_clusters);
    idx = cluster(gm,X);
    my_segmentation = reshape(idx,da,db);

elseif strcmp(clustering_method,'watershed')
    %Perform fit, clustering & adjust result as a matrix again
    
    hy = fspecial('sobel');
    hx = hy';
    Iy = imfilter(double(img), hy, 'replicate');
    Ix = imfilter(double(img), hx, 'replicate');
    grad = sqrt(Ix.^2 + Iy.^2);

    
    %TODO - Cómo interpretar el concepto de cluster en watersheds?
    %este algorítmo considera solo componentes conexas
    %Idea: 
    % - calcular promedio por componente conexo (crea un punto)
    % - clustering sobre puntos generados en number_of_clusters
    h =  max(max(max(grad(:,:,1))));
    marker = imextendedmin(grad(:,:,1), h);
    new_grad = imimposemin(grad(:,:,1), marker);
    my_segmentation = watershed(new_grad);
    mx = max(max(max(my_segmentation)));
    while mx<= number_of_clusters
        h=h-1;
        marker = imextendedmin(grad(:,:,1), h);
        new_grad = imimposemin(grad(:,:,1), marker);
        my_segmentation = watershed(new_grad);  
        mx = max(max(max(my_segmentation)));
    end

    
    
elseif strcmp(clustering_method,'hierarchical')
    %Perform fit, clustering & adjust result as a matrix again
    Y = pdist(Xl);
    Z = linkage(Y,'average');
    idx = cluster(Z, 'maxclust', number_of_clusters);
    segl = reshape(idx,dal,dbl);
    
    my_segmentation = zeros(da,db);
    
    %Calculate centroids
    centroids =  double(zeros(number_of_clusters, dc));
    countC = zeros(number_of_clusters, 1);
    for x = 1:dal
        for y = 1:dbl
            for k = 1:dc
                centroids(segl(x,y),k) = centroids(segl(x,y),k) + double(imgl(x,y,k));
            end
            countC(segl(x,y),1) = countC(segl(x,y),1)+1;
        end
    end
    
    for i = 1:number_of_clusters
        for k = 1:dc
            centroids(i,k) = centroids(i,k)/countC(i,1); 
        end
    end
    
    
            
    for x = 1:da
        for y = 1:db
            clusterN = 0;
            distMin = 9999999;
            for i = 1:number_of_clusters
                    v = reshape(img(x,y,:),1,dc);
                    vl = reshape(centroids(i,:),1,dc);
                    %v = [img(x,y,1) img(x,y,2) img(x,y,3)];
                    %vl = [centroids(i,1) centroids(i,2) centroids(i,3)];
                    if norm(double(v)-double(vl)) < distMin
                       distMin = norm(double(v)-double(vl));
                       clusterN = i;
                    end   
               
            end
            my_segmentation(x,y) = clusterN;
            
        end
    end

end 

%k-means, gmm, hierarchical or watershed


end

