function [ my_segmentation ] = seg_method_kmeans( img, number_of_clusters, feature_space )
%

%Reshape as a vector
[da, db, dc] = size(img);
X = double(reshape(img,da*db,dc));

%Perform clustering & adjust result as a matrix again
[idx, ctrs] = kmeans(X, number_of_clusters);
my_segmentation = reshape(idx,da,db);

end

