function my_segmentation = segment_by_clustering( rgb_image, feature_space, clustering_method, number_of_clusters)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


img = zeros(1,1);
if strcmp(feature_space,'lab')
    img = transform_rgb2lab( rgb_image );

elseif strcmp(feature_space,'labxy')
    img = transform_rgb2labxy( rgb_image );

elseif strcmp(feature_space,'rgb')
    img = rgb_image;

elseif strcmp(feature_space,'rgbxy')
    img = transform_rgb2rgbxy( rgb_image );
    
elseif strcmp(feature_space,'hsv')
    img = transform_rgb2hsv( rgb_image );    

elseif strcmp(feature_space,'hsvxy')
    img = transform_rgb2hsvxy( rgb_image );

end


%Clustering Methods
if strcmp(clustering_method,'k-means')
    my_segmentation = seg_method_kmeans( img, number_of_clusters, feature_space );

elseif strcmp(clustering_method,'gmm')
    my_segmentation = seg_method_gmm( img, number_of_clusters, feature_space );

elseif strcmp(clustering_method,'hierarchical')
    my_segmentation = seg_method_hierarchical( img, number_of_clusters, feature_space, 0.20 );
    
elseif strcmp(clustering_method,'watershed')
    my_segmentation = seg_method_watershed( img, number_of_clusters, feature_space);
    
    

end 

%k-means, gmm, hierarchical or watershed


end

