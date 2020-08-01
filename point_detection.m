function [pt] = point_detection(im, filter, thres)
% point_detection - 点检测
%
% input:
%   - im: m*n*c, uint8, 待处理图像, c=3 时为 rgb 图像, c=1 时为灰度图像
%   - filter: k*k, 点检测处理对应的滤波核大小, k 一般为奇数, 常用 k=3
%   - thres: scale, 点检测阈值
% output:
%   - pt: m*n, 点检测后的二值化图像, [0, 1]
%
% example:
%   im = imread(image_path);
%   pt = point_detection(im); % filter, thres 使用默认值
%

if ~exist('filter', 'var')
    filter = [-1, -1, -1; ...
              -1,  8, -1; ...
              -1, -1, -1];
end

[m, n, c] = size(im);
if c == 3
    im = rgb2gray(im);
end
im = double(im) / 255;

g = imfilter(im, filter);
pt = zeros(m, n);

if ~exist('thres', 'var')
    thres = 0.25 * max(g(:));
end

pt(g > thres) = 1;

end

