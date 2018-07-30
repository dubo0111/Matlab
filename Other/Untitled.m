function [t ,A] = Untitled
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
tic;
A=zeros(50000,1);


for i=1:50000
a=i;
A(i)=[a];
end
toc;
t=toc;

