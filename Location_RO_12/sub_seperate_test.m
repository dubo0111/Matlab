clear
load test2
result_Q = zeros(1,num_k);
for nk = 1:num_k
    result_Q = Sub_mode_seperate (y, ni, nj, K, nk, C1, D1 )
end
[a,b] = max (result_Q)