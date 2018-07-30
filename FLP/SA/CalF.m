function F=CalF(dislist,s,fc)
s1=s;
%生成固定染色体序列
fixed=zeros(1,60);
for i=324:383
    fixed(1,i-323)=i;
end
for j=1:size(fixed,2)
   s1(1,size(s,2)+j)=fixed(j);
end
F=0;
n=size(s1,2);
for i=1:n
    for j=i:n
        if i~=j
%             if s1(j)==0
%                 aaa=6;
%             end
            F=F+fc(i,j).*dislist(s1(i),s1(j));
        end
    end
end

end