I = imread('16110101001_01.jpg');
I=rgb2gray(I);
imshow(I)
title('Original Image');
text(size(I,2),size(I,1)+15, ...
    'Image courtesy of Alan Partin', ...
    'FontSize',7,'HorizontalAlignment','right');
text(size(I,2),size(I,1)+25, ....
    'Johns Hopkins University', ...
    'FontSize',7,'HorizontalAlignment','right');
[~,threshold] = edge(I,'sobel');
fudgeFactor = 0.5;
BWs = edge(I,'sobel',threshold * fudgeFactor);
imshow(BWs)
title('Binary Gradient Mask')
se90 = strel('line',3,90);
se0 = strel('line',3,0);
BWsdil = imdilate(BWs,[se90 se0]);
BWdfill = imfill(BWsdil,'holes');
imshow(BWdfill)
title('Binary Image with Filled Holes')
imshow(BWsdil)
title('Dilated Gradient Mask')
x = 1:576;
y = 1:768;
% DT = delaunay(x,y);
triplot(double(I),x,y);

BW = im2bw(I, graythresh(I));%二值化
[B,L] = bwboundaries(BW,'noholes');%寻找边缘，不包括孔
imshow('1.jpg');%原图
hold on
for k = 1:length(B)
boundary = B{k};

plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
[A,rect] = imcrop(I);
imshow(A);
rect
imwrite(A,'D:\gastric cancer images\2.png');


BW = im2bw(I, graythresh(I));%转换成2进制图像
[B,L] = bwboundaries(BW,'noholes');%寻找边缘，不包括孔
imshow(label2rgb(L, @jet, [.5 .5 .5]))%显示图像
hold on
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end%整个循环表示的是描边
I1 = DrawRectangle(I,[rect(2),rect(1)],[rect(2)+rect(4),rect(1)+rect(3)]); 

imshow(flag); % 展示图像     
% 将图像的rgb色彩空间转化至hsv色彩空间
flag_hsv = rgb2hsv(flag);      
% 创建一个白色图像，将特定颜色提取到此处
flag_new = 255*ones(size(flag));
% 将该图像转至hsv色彩空间
flag_new_hsv = rgb2hsv(flag_new);
% 找出图像中绿色的像素
[row, col] = ind2sub(size(flag_hsv),find(flag_hsv(:,:,1)>0.12...
& flag_hsv(:,:,1)< 0.6 & flag_hsv(:,:,2)>0.16 & flag_hsv(:,:,3)>0.18));
% 将图像中的绿色像素复制到刚才新建的白色图像中
for i = 1 : length(row)
    flag_new_hsv(row(i),col(i),:) = flag_hsv(row(i),col(i),:);
end
% 将提取出来的绿色，转化至rgb空间，进行展示
flag_green = hsv2rgb(flag_new_hsv);
figure
imshow(flag_green)


for i=1:1

f=strcat('D:\gastric cancer images\16110101001\','16110101001_0',num2str(i));

image=strcat(f,'.jpg');

PS=imread(image);

PS=imresize(PS,[300,300],'bilinear');%归一化大小

PS=rgb2gray(PS);

[m,n]=size(PS); %测量图像尺寸参数

GP=zeros(1,256); %预创建存放灰度出现概率的向量

for k=0:255

GP(k+1)=length(find(PS==k))/(m*n); %计算每级灰度出现的概率，将其存入GP中相应位置

end

%直方图均衡化

S1=zeros(1,256);

for i=1:256

for j=1:i

S1(i)=GP(j)+S1(i); %计算Sk

end

end

S2=round((S1*256)+0.5); %将Sk归到相近级的灰度

%图像均衡化

f=PS;

for i=0:255

f(find(PS==i))=S2(i+1); %将各个像素归一化后的灰度值赋给这个像素

end

figure,imshow(f);

%边缘检测

f=edge(f,'canny',0.25);

imshow(f);

%二值法锐化图像

f=double(f);

[x,y]=gradient(f);

g=sqrt(x.*x+y.*y);

i=find(g>=0.5);

g(i)=256;

j=find(g<0.5);

g(j)=0;

imshow(g);

title('二值法锐化图像');

%中值滤波

g=medfilt2(g);

g=dither(g);

imshow(g);
imshow(strain_image,'border','tight','initialmagnification','fit');  
set (gcf,'Position',[0,0,500,500]); 