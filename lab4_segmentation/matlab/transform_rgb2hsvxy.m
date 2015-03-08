function [ output_img ] = transform_rgb2hsvxy( rgb_image )
%Transforms rgb_image to hsvxy color space
    img =  uint8(rgb2hsv(rgb_image)*255.0);
    
    [n, m, c] = size(img);
    output_img = zeros(n,m,5);
    output_img(:, :, 1:3) = img(:, :, :);
    for x = 1:n
        for y = 1:m
            output_img(x,y,4) = x;
            output_img(x,y,5) = y;            
        end
    end
    n=2;
end


