function [ my_segmentation ] = seg_method_gmm( img, number_of_clusters, feature_space )
%

%Reshape as a vector
[da, db, dc] = size(img);
X = double(reshape(img,da*db,dc));

%Perform fit, clustering & adjust result as a matrix again
options = statset('Display','iter');
gm = gmdistribution.fit( X, number_of_clusters, 'Options', options, 'CovType', 'Diagonal' );
idx = cluster( gm, X );
my_segmentation = reshape( idx, da, db );

end

