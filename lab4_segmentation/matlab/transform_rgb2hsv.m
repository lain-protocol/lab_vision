function [ output_img ] = transform_rgb2hsv( rgb_image )
%Transforms rgb_image to hsv color space

output_img =  uint8(rgb2hsv(rgb_image)*255.0);

end
