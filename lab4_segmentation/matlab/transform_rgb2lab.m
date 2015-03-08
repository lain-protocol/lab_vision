function [ output_img ] = transform_rgb2lab( rgb_image )
%Transforms rgb_image to Lab color space
    colorTransform = makecform('srgb2lab');
    output_img = applycform(rgb_image, colorTransform);
end

