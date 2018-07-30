function [ ck,dk ] = real_cd( c,d )
%REAL_CD Real cost&demand generator
[ni,nj] = size(c);
rand_c1 = rand(ni,nj)-0.5+1;
rand_d1 = rand(ni,1)-0.5+1;
ck = c.*rand_c1;
dk = d.*rand_d1;
end

