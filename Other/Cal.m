function [Y] = Cal(m,n)
%´´Ôì×ø±ê¾ØÕó
syms Y A jj;
A=ones(m,n);
for i=1:m
    for j= 1:n
        jj=mod(j,2);
        if jj==0
            A(i,j)=j/2;
        else
            A(i,j)=i;
        end
    end
end
Y=A;

end


