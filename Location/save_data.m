%save_data
%¥¢¥Êc,d,ck,dk
xlswrite('c.xls',c);xlswrite('d.xls',d);xlswrite('ck.xls',ck);xlswrite('dk.xls',dk);
%¥¢¥ÊK
[~,b] = size(K);
for i = 1:b
    sheet = ['A',num2str(i)];
    xlswrite('K.xls',K{i},1,sheet)
end
%¥¢¥ÊC1,C2
[Ca,Cb] = size(C1{1});
cc1 = zeros(Ca,Cb*b);cc2 = zeros(Ca,Cb*b);
for i = 1:b
    ii = Cb*(i-1)+1;
    cc1(:,ii:ii+Cb-1) = C1{i};cc2(:,ii:ii+Cb-1) = C2{i};
end
xlswrite('C1.xls',cc1);xlswrite('C2.xls',cc2);
%¥¢¥ÊD1,D2
[Da,~] = size(D1{1});
dd1 = zeros(Da,b);dd2 = zeros(Da,b);
for i = 1:b 
    dd1(:,i) = D1{i};
    dd2(:,i) = D2{i};
end
xlswrite('D1.xls',dd1);xlswrite('D2.xls',dd2);

