close all
clear all
clc


nPts = 10000;

%p = [-0.7321, -0.9382, 0.8783];    % 4th order solution
%p = [0.9383, -0.9925, -0.9446];    % 5th order solution
%p = [0.8840, -0.9449, -0.9945];    % 7th order solution
%p = [0.9733, -0.8416, -0.9843];    % 9th order solution (but struggles to converge)
p = [-0.9348, -0.9496, 0.7439];    % 10th order
xInit = 0.01;

x = zeros(nPts, 1);
x(1) = xInit;
for n = 2:nPts
  x(n) = polyval(p,(x(n-1)));
end

plot(x)
grid minor