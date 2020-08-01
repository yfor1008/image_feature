close all
clear
clc

im = imread('test_images/lena.png');
% figure, imshow(im);

% 
type = 'prewitt';
bw = edge_detection(im, type);
bw = bw * 255;

%
[ht] = hough_detection(bw);
imshow(ht)
