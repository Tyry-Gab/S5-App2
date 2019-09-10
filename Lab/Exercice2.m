%% Init
clear
clc

%% The good stuff

Xn = [2.3 14.7 29.7 31.9 45.7 58.6];
Yn = [184 860 1345 1385 1360 965];
M = [1;2;3];

papa_matrice = [
                [6 sum(Xn) sum(Xn.^2)]; 
                [sum(Xn) sum(Xn.^2) sum(Xn.^3)];
                [sum(Xn.^2) sum(Xn.^3) sum(Xn.^4)]
                ]
matrix_sum_y = [sum(Xn); sum(Xn.*Yn); sum((Xn.^2).*Yn)]
matrix_a = matrix_sum_y * inv(papa_matrice)
    






%% Plotting
figure
plot(Xn,Yn)