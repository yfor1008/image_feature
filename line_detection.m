function [lt] = line_detection(im, filter, thres)
% line_detection - 线检测, 仅针对二值化图像
%
% input:
%   - im: m*n*c, uint8, 待处理图像, c=3 时为 rgb 图像, c=1 时为灰度图像
%   - filter: k*k, 线检测处理对应的滤波核大小, k 一般为奇数, 常用 k=3
%   - thres: scale, 线检测阈值
% output:
%   - lt: m*n, 线检测后的二值化图像, [0, 1]
%
% example:
%   im = imread(image_path);
%   lt = line_detection(im); % filter, thres 使用默认值
%

if ~exist('filter', 'var')
    filter = [-1, -1, -1; ...
               4,  4,  4; ...
              -1, -1, -1];
end

[m, n, c] = size(im);
if c == 3
    im = rgb2gray(im);
end
im = double(im) / 255;

g = imfilter(im, filter);
g = g / 4;
lt = zeros(m, n);

if ~exist('thres', 'var')
    thres = 0.1 * max(g(:));
end

lt(g < thres) = 1;

end

