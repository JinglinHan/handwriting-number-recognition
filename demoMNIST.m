clc
clear
%读取MNIST数据集中的图片

train_images = readMNISTImages('train-images.idx3-ubyte'); %60000个训练集,大小为28*28*60000

test_images =  readMNISTImages('t10k-images.idx3-ubyte');  %10000个训练集,大小为28*28*10000

%读取MNIST数据集中的标签

train_labels = readMNISTLabels('train-labels.idx1-ubyte');%标签0~9；60000个标签，大小为60000*1

test_labels = readMNISTLabels('t10k-labels.idx1-ubyte'); %10000个标签，大小为10000*1

train_img=reshape(train_images,28*28,60000)./255;
test_img=reshape(test_images,28*28,10000)./255;
train_labels_m=zeros(10,60000);
test_labels_m=zeros(10,10000);

for i=1:60000
    train_labels_m((train_labels(i)+1),i)=1;
end
% for i=1:10000
%     test_labels_m((test_labels(i)+1),i)=1;
% end
[w,b,w_h,b_h]=train(train_img,train_labels_m);
acc0=test(test_img,test_labels,w,b,w_h,b_h);%test accuracy in 10000 test samples.
fprintf('正确率: %d/10000\n',acc0);

%%
test_num=str2num(input('请输入需要识别的图像变换:\n','s'));
l=length(test_num);
figure(1);
fprintf('识别结果为：\n')
for i=1:l
    x = test_img(:,test_num(i));
    hid = layerout(w_h,b_h,x);
    re=layerout(w,b,hid);
    for j=1:10
        if re(j)==max(re)
            break;
        end
    end
    j=j-1;
    subplot(l,1,i);
    imshow(test_images(:,:,test_num(i)));
    fprintf('%d\n',j);
end

%%
acc=zeros(length([0:0.05:1]));
ct=1;
for var=0:0.05:1
    test_images_n=test_images./255;
    for j=1:10000
        test_images_n(:,:,j)=imnoise(test_images_n(:,:,j),'gaussian',var);
    end
    test_img_n=reshape(test_images_n,28*28,10000);
    acc(ct)=test(test_img_n,test_labels,w,b,w_h,b_h)./10000.*100;
    ct=ct+1;
end
figure(2);
x=0:0.05:1;
plot(x,acc(:,1),'-*r');
xlabel('高斯噪声方差');
ylabel('识别准确率/%');








% test(test_img,test_labels,w,b,w_h,b_h);

