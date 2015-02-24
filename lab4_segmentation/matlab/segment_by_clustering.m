function my_segmentation = segment_by_clustering( rgb_image, feature_space, clustering_method, number_of_clusters)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


img = zeros(1,1);
if strcmp(feature_space,'lab')
    %Transform to color space
    colorTransform = makecform('srgb2lab');
    img = applycform(rgb_image, colorTransform);
end

%'rgb'    , 'lab', 'hsv', 'rgb+xy', 'lab+xy', 'hsv+xy'


%put values on an array
[da, db, dc] = size(img);
X = double(reshape(img,da*db,3));
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

elseif strcmp(clustering_method,'hierarchical')
    %Perform fit, clustering & adjust result as a matrix again
    Y = pdist(X);
    Z = linkage(Y,'average');
    idx = cluster(Z, 'maxclust', number_of_clusters);
end 

%k-means, gmm, hierarchical or watershed


end

