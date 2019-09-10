%% Init
clear
clc

%% The good stuff

Xn = [1 3 4 6 7];
Yn = [-1.6 4.8 6.1 14.6 15.1 ];
m1 = inv([[5 sum(Xn)];[sum(Xn) sum(Xn.^2)]]);
m2 = [sum(Yn); sum(Xn.*Yn)];

rep = m1*m2;