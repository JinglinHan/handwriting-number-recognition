
function labels = readMNISTLabels(filename)

%

%功能：读取MNIST数据集中的标签

%

%Input：

%filename - 文件名

%

%Output：

%labels - 读取的标签（1*标签数）



fid = fopen(filename,'r');

 

%读取前八字节

magic = fread(fid,1,'int32',0,'ieee-be');

%或

% magic = fread(fid,4);

% magic = ((magic(1)*256 + magic(2))*256+magic(3))*256 + magic(4);

numLabels = fread(fid,1,'int32',0,'ieee-be');

 

%读取标签

labels = fread(fid,Inf,'unsigned char');

labels = labels';



fclose(fid);



end


