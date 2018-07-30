for i = 1:72
    for j  = 1:14
        if A(i,j)~=0 && A(i,j)<1e-8
            A(i,j) = 0;
        end
        if A(i,j) >1000
            A(i,j) = 1000;
        end
    end
end
A1=A
            