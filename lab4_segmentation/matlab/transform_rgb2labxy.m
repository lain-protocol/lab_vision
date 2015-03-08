function [ output_img ] = transform_rgb2labxy( rgb_image )
%Transforms rgb_image to Lab color space
    colorTransform = makecform('srgb2lab');
    img = applycform(rgb_image, colorTransform);
    
    [n, m, c] = size(img);
    output_img = zeros(n,m,5);
    output_img(:, :, 1:3) = img(:, :, :);
    for x = 1:n
        for y = 1:m
            output_img(x,y,4) = x;
            output_img(x,y,5) = y;            
        end
    end
end


