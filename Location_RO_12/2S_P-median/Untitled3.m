clear
count_data = 1; %save data
final_result=zeros(4*6,2);

for iter=4:6;
    num_test = 10;num_k=4;
    result = zeros(num_test+1,8);
    
    for nn = 1:num_test
        Main_Function(iter,count_data,num_k)
        count_data = count_data+1;
        load test
        % p-center
        tic
        [cdx1,cdw1,L1_1,L2_1,x1,y1] = center1;
        toc
        % p-median
        tic
        [cdx2,cdw2,L1_2,L2_2,x2,y2] = median1;
        toc

        A = [cdx1,cdw1,L1_1,L2_1];
        B = [cdx2,cdw2,L1_2,L2_2];
        result(nn,:)=[A,B];
    end
    %
    for i = 1:8
        result(num_test+1,i) = sum(result(1:num_test,i))/num_test;
    end
    
    final_result(4*(iter-1)+1:4*(iter-1)+4,:)=reshape((result(num_test+1,:))',4,2);
    final_result=final_result
    
    filename = ['result_',num2str(iter),'.mat'];
    save(filename,'result')
end
xlswrite('Result.xls',final_result);
