function [ obj_rgbmean ] = getcolors( Image, n)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%Image �����ͼ��
%n ��ȡͼƬ�Ĵ���
%obj_rgbmeanĿ��ͼ��rjb��ֵ����
obj_rgbmean=[];%�������Ŀ��ͼ��rjb��ֵ����
nR = []; %������ž�������RGB��ֵ������
nG = [];
nB = [];
figure
for i=1:n
imshow(Image);
h = imrect;%�����ʮ�֣�����ѡȡ����Ȥ����
pos = getPosition(h); %pos���ĸ�ֵ���ֱ��Ǿ��ο�����½ǵ������ x y �� ��� ��Ⱥ͸߶�
imag = imcrop(Image, pos);%imcrop(I,[a b c d]);���òü������ü�ͼ��
imshow(imag);

image_R=imag(:,:,1); %����RGB��������
image_G=imag(:,:,2);
image_B=imag(:,:,3);

R=mean(image_R(:)); %����RGB��������ľ�ֵ
G=mean(image_G(:));
B=mean(image_B(:));
nR(i)=R;%��ÿ��ͼ���RGB�����ֵ����nr��ng��nb������
nG(i)=G;
nB(i)=B;
end
obj_rgbmean=cat(1,nR,nG,nB);
figure
plot(1:n,nR,'r', 1:n,nG,'g', 1:n, nB,'b');%�������з�֡������ͼ���RGB�����ֵ����ͼ

%%RGB����ͼע��˵��

xlabel('Ŀ����');  %����ͼע��˵��
ylabel('��ֵ');
title('����RGB��ֵ����ͼ');
legend('R', 'G', 'B');
end
