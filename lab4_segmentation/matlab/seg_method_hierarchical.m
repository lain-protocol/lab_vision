function [ my_segmentation ] = seg_method_hierarchical( img, number_of_clusters, feature_space, resize )
%

%Reshape as a vector for original and small image
[da, db, dc] = size( img );
X = double( reshape( img, da*db, dc ) );

imgl = imresize( img, resize );
[dal, dbl, dcl] = size( imgl );
Xl = double(reshape( imgl, dal*dbl, dcl ));

%Perform fit, clustering & adjust result as a matrix again
Y = pdist(Xl);
Z = linkage(Y,'average');
idx = cluster(Z, 'maxclust', number_of_clusters);
segl = reshape( idx, dal, dbl );

my_segmentation = zeros( da, db );

%Calculate centroids
if strcmp(feature_space, 'rgb') || strcmp(feature_space, 'lab') || strcmp(feature_space, 'hsv')

    centroids =  double( zeros( number_of_clusters, dc ) );
    countC = zeros(number_of_clusters, 1);
    for x = 1:dal
        for y = 1:dbl
            for k = 1:dc
                centroids(segl(x,y),k) = centroids(segl(x,y),k) + double(imgl(x,y,k));
            end
            countC(segl(x,y),1) = countC(segl(x,y),1) + 1;
        end
    end

    for i = 1:number_of_clusters
        for k = 1:dc
            centroids(i,k) = centroids(i,k)/countC(i,1);
        end
    end


    %Apply centroids to pixels on original image
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
    
else
centroids =  double( zeros( number_of_clusters, dc ) );
    countC = zeros(number_of_clusters, 1);
    for x = 1:dal
        for y = 1:dbl
            for k = 1:dc
                centroids(segl(x,y),k) = centroids(segl(x,y),k) + double(imgl(x,y,k));
            end
            countC(segl(x,y),1) = countC(segl(x,y),1) + 1;
        end
    end

    for i = 1:number_of_clusters
        for k = 1:dc
            centroids(i,k) = centroids(i,k)/countC(i,1);
        end
    end


    %Apply centroids to pixels on original image
    for x = 1:da
        for y = 1:db
            clusterN = 0;
            distMin = 9999999;
            for i = 1:number_of_clusters
                v = [reshape(img(x,y,:),1,dc)];
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
    
    
end

