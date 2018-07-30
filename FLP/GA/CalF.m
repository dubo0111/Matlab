function F=CalF(dislist,s1,fc)

F=0;
n=size(s1,2);
for i=1:n
    for j=i:n
        if i~=j
            F=F+fc(i,j).*dislist(s1(i),s1(j));
        end
    end
end

end