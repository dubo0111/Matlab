function c = zbl(  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 P=[3.2 3.2 3 3.2 3.2 3.4 3.2 3 3.2 3.2 3.2 3.9 3.1 3.2;

9.6 10.3 9 10.3 10.1 10 9.6 9 9.6 9.2 9.5 9 9.5 9.7;

3.45 3.75 3.5 3.65 3.5 3.4 3.55 3.5 3.55 3.5 3.4 3.1 3.6 3.45;

2.15 2.2 2.2 2.2 2 2.15 2.14 2.1 2.1 2.1 2.15 2 2.1 2.15;

140 120 140 150 80 130 130 100 130 140 115 80 90 130;

2.8 3.4 3.5 2.8 1.5 3.2 3.5 1.8 3.5 2.5 2.8 2.2 2.7 4.6;

11 10.9 11.4 10.8 11.3 11.5 11.8 11.3 11.8 11 11.9 13 11.1 10.85;

50 70 50 80 50 60 65 40 65 50 50 50 70 70];

T=[2.24 2.33 2.24 2.32 2.2 2.27 2.2 2.26 2.2 2.24 2.24 2.2 2.2 2.35];

[p1,minp,maxp,t1,mint,maxt]=premnmx(P,T);

%创建网络

net=newff(minmax(P),[8,6,1],{'tansig','tansig','purelin'},'trainlm');

%设置训练次数

net.trainParam.epochs = 5000;

%设置收敛误差

net.trainParam.goal=0.0000001;

%训练网络

[net,tr]=train(net,p1,t1);

TRAINLM, Epoch 0/5000, MSE 0.533351/1e-007, Gradient 18.9079/1e-010

TRAINLM, Epoch 24/5000, MSE 8.81926e-008/1e-007, Gradient 0.0022922/1e-010
% 
TRAINLM, Performance

%将输入数据归一化

a=premnmx(a);

%放入到网络输出数据

b=sim(net,a);

%将得到的数据反归一化得到预测数据

c=postmnmx(b,mint,maxt);

zbl=c;

end

