# 点检测

## 孤立点的定义

在图像 $f$ 中, 若存在一个像素点 $p$ , 其灰度值与其周围其他像素的灰度值差别 $R$ 很大, 超过了阈值 $T$ , 则该点为孤立点, 如下式所示:
$$
R≥T
$$

式中, $T$ 为设定的阈值(需根据实际情况调整), $R$ 的计算方式为:
$$
R=\sum_{i=1}^{n*n}w_iz_i
$$
式中, $w_i$ , $z_i$ 分别为像素点 $p$ 邻域大小为 $n*n$ 的区域内像素值的权重(滤波核)和像素值. 一般地, 周围邻域大小 $n$ 为奇数, 如: 3, 5, 7 ... 等, 常用为 $n=3$, 如下所示为常用的权重值:

|      |      |      |
| :--: | :--: | :--: |
|  -1  |  -1  |  -1  |
|  -1  |  8   |  -1  |
|  -1  |  -1  |  -1  |

## 点检测原理

利用上述公式, 对图像在空域进行滤波处理.

## 检测效果
