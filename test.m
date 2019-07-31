function[sum]= test(test_img,test_labels,w,b,w_h,b_h)
%x_test:测试样本的像素数据
%y_test：测试样本的标签
%w：输出层权重
%b：输出层偏置
%w_h：隐藏层权重
%b_h：隐藏层偏置

test = zeros(10,10000);
for k=1:10000
    x = test_img(:,k);

    hid = layerout(w_h,b_h,x);
    test(:,k)=layerout(w,b,hid);
end
%正确率
    result=max(test);

    sum = 0;
    for p=1:10000
        for q=1:10
            if result(p)==test(q,p)
                if test_labels(p)==(q-1)
                    sum=sum+1;
                end
            end
        end
    end



end
