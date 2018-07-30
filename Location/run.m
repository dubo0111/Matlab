n1 = 0;n1_12 = 0;n1_21 = 0;n2_12 = 0;n2_21 = 0;n3_12 = 0;n3_21 = 0;c_12=0;c_21=0;ct_12=0;ct_21=0;cb_12=0;cb_21=0;cr_12=0;cr_21=0;
r=result;
[a,b] = size(r);
for  i = 1:a
   if r(i,4) == r(i,11)
       n1 = n1 + 1;
   end
   %if r(i,1) == r(i,4)
       if r(i,1) > r(i,8) 
           n1_12 = n1_12 + 1;
       elseif r(i,1) <= r(i,8);
           n1_21 = n1_21 + 1;
       end
       if r(i,2) > r(i,9) 
           n2_12 = n2_12 + 1;
       elseif r(i,2) <= r(i,9);
           n2_21 = n2_21 + 1;
       end
       if r(i,3) > r(i,10) 
           n3_12 = n3_12 + 1;
       elseif r(i,3) <= r(i,10) 
           n3_21 = n3_21 + 1;
       end
       if r(i,4) > r(i,11) 
           c_12 = c_12 + 1;
       elseif r(i,4) <= r(i,11) 
           c_21 = c_21 + 1;
       end
       if r(i,5) > r(i,12) 
           ct_12 = ct_12 + 1;
       elseif r(i,5) <= r(i,12) 
           ct_21 = ct_21 + 1;
       end
       if r(i,6) > r(i,13) 
           cb_12 = cb_12 + 1;
       elseif r(i,6) <= r(i,13) 
           cb_21 = cb_21 + 1;
       end
       if r(i,7) > r(i,14) 
           cr_12 = cr_12 + 1;
       elseif r(i,7) <= r(i,14) 
           cr_21 = cr_21 + 1;
       end
   %end
end
nn = ['  有',num2str(n1),'项相同'];disp(nn)
n1_12 = ['  新建设施前，模型2有',num2str(n1_12),'项优于模型1'] ;disp(n1_12)%
n1_21 = ['  新建设施前，模型1有',num2str(n1_21),'项不差于模型2'] ;disp(n1_21)%
n2_12 = ['  新建设施前，模型2有',num2str(n2_12),'项优于模型1'] ;disp(n2_12)%
n2_21 = ['  新建设施前，模型1有',num2str(n2_21),'项不差于模型2'] ;disp(n2_21)%
n3_12 = ['  新建设施后，模型2有',num2str(n3_12),'项优于模型1'] ;disp(n3_12)%
n3_21 = ['  新建设施后，模型1有',num2str(n3_21),'项不差于模型2'] ;disp(n3_21)%
c_12 = ['  新建设施总成本，模型2有',num2str(c_12),'项优于模型1'] ;disp(c_12)%
c_21 = ['  新建设施总成本，模型1有',num2str(c_21),'项不差于模型2'] ;disp(c_21)%
ct_12 = ['  总运输成本，模型2有',num2str(ct_12),'项优于模型1'] ;disp(ct_12)%
ct_21 = ['  总运输成本，模型1有',num2str(ct_21),'项不差于模型2'] ;disp(ct_21)%
cb_12 = ['  设施建设成本，模型2有',num2str(cb_12),'项优于模型1'] ;disp(cb_12)%
cb_21 = ['  设施建设成本，模型1有',num2str(cb_21),'项不差于模型2'] ;disp(cb_21)%
cr_12 = ['  重新分配的惩罚成本，模型2有',num2str(cr_12),'项优于模型1'] ;disp(cr_12)%
cr_21 = ['  重新分配的惩罚成本，模型1有',num2str(cr_21),'项不差于模型2'] ;disp(cr_21)%

sum_r = zeros(1,14);
for i = 1:b
    sum_r(i) = sum(r(:,i));
end
sum_r = sum_r/i_end %均值
sum_diff_r = [(sum_r(8)-sum_r(1))/sum_r(8),(sum_r(9)-sum_r(2))/sum_r(9),(sum_r(10)-sum_r(3))/sum_r(10),(sum_r(11)-sum_r(4))/sum_r(11), ...
    (sum_r(12)-sum_r(5))/sum_r(12),(sum_r(13)-sum_r(6))/sum_r(13),(sum_r(14)-sum_r(7))/sum_r(14)] %改进











