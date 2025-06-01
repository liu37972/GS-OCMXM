function [ obj_rgbmean ] = getcolors( Image, n)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
%Image 待检测图像
%n 截取图片的次数
%obj_rgbmean目标图像rjb均值矩阵
obj_rgbmean=[];%用来存放目标图像rjb均值矩阵
nR = []; %用来存放矩形区域RGB均值的数组
nG = [];
nB = [];
figure
for i=1:n
imshow(Image);
h = imrect;%鼠标变成十字，用来选取感兴趣区域
pos = getPosition(h); %pos有四个值，分别是矩形框的左下角点的坐标 x y 和 框的 宽度和高度
imag = imcrop(Image, pos);%imcrop(I,[a b c d]);利用裁剪函数裁剪图像
imshow(imag);

image_R=imag(:,:,1); %构建RGB三个矩阵
image_G=imag(:,:,2);
image_B=imag(:,:,3);

R=mean(image_R(:)); %计算RGB三个矩阵的均值
G=mean(image_G(:));
B=mean(image_B(:));
nR(i)=R;%将每个图像的RGB矩阵均值存入nr、ng、nb数组中
nG(i)=G;
nB(i)=B;
end
obj_rgbmean=cat(1,nR,nG,nB);
figure
plot(1:n,nR,'r', 1:n,nG,'g', 1:n, nB,'b');%绘制所有分帧区域内图像的RGB矩阵均值折线图

%%RGB曲线图注释说明

xlabel('目标数');  %曲线图注释说明
ylabel('均值');
title('区域RGB均值曲线图');
legend('R', 'G', 'B');
end
