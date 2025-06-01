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

BW = im2bw(I, graythresh(I));%��ֵ��
[B,L] = bwboundaries(BW,'noholes');%Ѱ�ұ�Ե����������
imshow('1.jpg');%ԭͼ
hold on
for k = 1:length(B)
boundary = B{k};

plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
[A,rect] = imcrop(I);
imshow(A);
rect
imwrite(A,'D:\gastric cancer images\2.png');


BW = im2bw(I, graythresh(I));%ת����2����ͼ��
[B,L] = bwboundaries(BW,'noholes');%Ѱ�ұ�Ե����������
imshow(label2rgb(L, @jet, [.5 .5 .5]))%��ʾͼ��
hold on
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end%����ѭ����ʾ�������
I1 = DrawRectangle(I,[rect(2),rect(1)],[rect(2)+rect(4),rect(1)+rect(3)]); 

imshow(flag); % չʾͼ��     
% ��ͼ���rgbɫ�ʿռ�ת����hsvɫ�ʿռ�
flag_hsv = rgb2hsv(flag);      
% ����һ����ɫͼ�񣬽��ض���ɫ��ȡ���˴�
flag_new = 255*ones(size(flag));
% ����ͼ��ת��hsvɫ�ʿռ�
flag_new_hsv = rgb2hsv(flag_new);
% �ҳ�ͼ������ɫ������
[row, col] = ind2sub(size(flag_hsv),find(flag_hsv(:,:,1)>0.12...
& flag_hsv(:,:,1)< 0.6 & flag_hsv(:,:,2)>0.16 & flag_hsv(:,:,3)>0.18));
% ��ͼ���е���ɫ���ظ��Ƶ��ղ��½��İ�ɫͼ����
for i = 1 : length(row)
    flag_new_hsv(row(i),col(i),:) = flag_hsv(row(i),col(i),:);
end
% ����ȡ��������ɫ��ת����rgb�ռ䣬����չʾ
flag_green = hsv2rgb(flag_new_hsv);
figure
imshow(flag_green)


for i=1:1

f=strcat('D:\gastric cancer images\16110101001\','16110101001_0',num2str(i));

image=strcat(f,'.jpg');

PS=imread(image);

PS=imresize(PS,[300,300],'bilinear');%��һ����С

PS=rgb2gray(PS);

[m,n]=size(PS); %����ͼ��ߴ����

GP=zeros(1,256); %Ԥ������ŻҶȳ��ָ��ʵ�����

for k=0:255

GP(k+1)=length(find(PS==k))/(m*n); %����ÿ���Ҷȳ��ֵĸ��ʣ��������GP����Ӧλ��

end

%ֱ��ͼ���⻯

S1=zeros(1,256);

for i=1:256

for j=1:i

S1(i)=GP(j)+S1(i); %����Sk

end

end

S2=round((S1*256)+0.5); %��Sk�鵽������ĻҶ�

%ͼ����⻯

f=PS;

for i=0:255

f(find(PS==i))=S2(i+1); %���������ع�һ����ĻҶ�ֵ�����������

end

figure,imshow(f);

%��Ե���

f=edge(f,'canny',0.25);

imshow(f);

%��ֵ����ͼ��

f=double(f);

[x,y]=gradient(f);

g=sqrt(x.*x+y.*y);

i=find(g>=0.5);

g(i)=256;

j=find(g<0.5);

g(j)=0;

imshow(g);

title('��ֵ����ͼ��');

%��ֵ�˲�

g=medfilt2(g);

g=dither(g);

imshow(g);
imshow(strain_image,'border','tight','initialmagnification','fit');  
set (gcf,'Position',[0,0,500,500]); 