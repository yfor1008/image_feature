function [ht] = hough_detection(im, degree_range, line_len, dtheta, drho)
% hough_detection - hough检测, 直线, 圆/椭圆, 仅对二值化图像
%
% input:
%   - im: m*n*c, uint8, 待处理图像, c=3 时为 rgb 图像, c=1 时为灰度图像
%   - degree_range: 1*2, 角度范围
%   - line_len: scale, 检测的最小长度
%   - dtheta: scale, \theta 的步长(弧度)
%   - drho: scale, \rho 的步长(像素)
% output:
%   - ht: m*n, 点检测后的二值化图像, [0, 1]
%
% example:
%   im = imread(image_path);
%   ht = hough_detection(im); % filter, thres 使用默认值
%

[m, n, c] = size(im);
if c == 3
    im = rgb2gray(im);
end
im = double(im) / 255;

if ~exist('dtheta', 'var')
    dtheta = 1;
end
dtheta = dtheta * pi / 180;

if ~exist('degree_range', 'var')
    degree_range = [-90, 90];
end
degree_range = degree_range * pi / 180;
radian_upper = max(degree_range);
radian_lower = min(degree_range);
theta_value = radian_lower : dtheta : radian_upper;
ntheta = length(theta_value);

if ~exist('line_len', 'var')
    line_len = 100;
end

if ~exist('drho', 'var')
    drho = 1;
end
rho_max = sqrt(m^2 + n^2);
nrho = ceil(2*rho_max / drho);

% 变换到极坐标参数空间
[rows, cols] = find(im);
rho_value = cols * cos(theta_value) + rows * sin(theta_value);
rho_index = round((rho_value + rho_max) / drho);

% 参数统计
rho_theta = zeros(nrho, ntheta);
for i = 1 : length(rows)
    for j = 1 : ntheta
        rho_theta(rho_index(i,j), j) = rho_theta(rho_index(i,j), j) + 1;
    end
end
% rho_theta(rho_index, :) = rho_theta(rho_index, :) + 1;

% 满足条件的直线
ht = zeros(m, n);
[rho_th, theta_th] = find(rho_theta > line_len);
for i = 1 : length(rho_th)
    theta = theta_value(theta_th(i));
    rho = rho_value(rho_th(i), theta_th(i));
    for j = 1 : length(rows)
        x = cols(j);
        y = rows(j);
        rho_tmp = x * cos(theta) + y * sin(theta);
        rate = rho_tmp / rho;
        if rate > 1 - 0.01 && rate < 1 + 0.01
            ht(y, x) = 1;
        end
    end
end

end