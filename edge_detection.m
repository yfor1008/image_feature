function [et] = edge_detection(im, type, thres)
% edge_detection - 边缘检测
%
% input:
%   - im: m*n*c, uint8, 待处理图像, c=3 时为 rgb 图像, c=1 时为灰度图像
%   - type: str, 边缘检测算子: prewitt, sobel, robinson, kirsch
%   - thres: scale, 线检测阈值
% output:
%   - et: m*n, 线检测后的二值化图像, [0, 1]
%
% example:
%   im = imread(image_path);
%   et = edge_detection(im); % fieter, thres 使用默认值
%

if ~exist('type', 'var')
    % 默认为 sobel
    wx = [-1, -2, -1; ...
           0,  0,  0; ...
           1,  2,  1];
    wy = wx';
else
    type = lower(type);
    switch type
        case 'prewitt'
            wx = [-1, -1, -1; ...
                   0,  0,  0; ...
                   1,  1,  1];
            wy = wx';
        case 'sobel'
            wx = [-1, -2, -1; ...
                   0,  0,  0; ...
                   1,  2,  1];
            wy = wx';
        case 'robinson'
            wx = [ 1,  1,  1; ...
                   1, -2,  1; ...
                  -1, -1, -1];
            wy = [-1,  1,  1; ...
                  -1, -2,  1; ...
                  -1,  1,  1];
        case 'kirsh'
            wx = [ 3,  3,  3; ...
                   3,  0,  3; ...
                  -5, -5, -5];
            wy = [-5,  3,  3; ...
                  -5,  0,  3; ...
                  -5,  3,  3];
        otherwise
            return
    end
end

[m, n, c] = size(im);
if c == 3
    im = rgb2gray(im);
end
im = double(im) / 255;

gx = imfilter(im, wx);
gy = imfilter(im, wy);
g = sqrt(gx .^ 2 + gy .^ 2);
et = zeros(m, n);

if ~exist('thres', 'var')
    thres = 0.25 * max(g(:));
end

et(g > thres) = 1;

end