function[sum]= test(test_img,test_labels,w,b,w_h,b_h)
%x_test:������������������
%y_test�����������ı�ǩ
%w�������Ȩ��
%b�������ƫ��
%w_h�����ز�Ȩ��
%b_h�����ز�ƫ��

test = zeros(10,10000);
for k=1:10000
    x = test_img(:,k);

    hid = layerout(w_h,b_h,x);
    test(:,k)=layerout(w,b,hid);
end
%��ȷ��
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