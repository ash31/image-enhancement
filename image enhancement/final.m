
clc
FDetect = vision.CascadeObjectDetector;


img = imread('im2.jpg');
k = imread('im.png');

BB = step(FDetect,img);

figure,
imshow(img); hold on
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:));
    my_limit=0.5;
low_limit=0.008;
up_limit=0.992;


[m1, n1, r1]=size(img);

if r1==3
    my_limit2=0.04;my_limit3=-0.04;
    a=rgb2ntsc(img);
    mean_adjustment=my_limit2-mean(mean(a(:,:,2)));
    a(:,:,2)=a(:,:,2)+mean_adjustment*(0.596-a(:,:,2));
    mean_adjustment=my_limit3-mean(mean(a(:,:,3)));
    a(:,:,3)=a(:,:,3)+mean_adjustment*(0.523-a(:,:,3));
else
    a=double(img)./255;
end

mean_adjustment=my_limit-mean(mean(a(:,:,1)));
a(:,:,1)=a(:,:,1)+mean_adjustment*(1-a(:,:,1));
if r1==3
    a=ntsc2rgb(a);
end

img=a.*255;

for k=1:r1
    arr=sort(reshape(img(:,:,k),m1*n1,1));
    v_min(k)=arr(ceil(low_limit*m1*n1));
    v_max(k)=arr(ceil(up_limit*m1*n1));
end

if r1==3
    v_min=rgb2ntsc(v_min);
    v_max=rgb2ntsc(v_max);
end

img=(img-v_min(1))/(v_max(1)-v_min(1));
imshow(img)


end

hold off;