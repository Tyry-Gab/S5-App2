%% Init
clear
clc

%% The good stuff

Xn = [2.3 14.7 29.7 31.9 45.7 58.6];
Yn = [184 860 1345 1385 1360 965];
M = [1;2;3];
N = numel(Xn);
papa_matrice = inv([
                [N sum(Xn) sum(Xn.^2)]; 
                [sum(Xn) sum(Xn.^2) sum(Xn.^3)];
                [sum(Xn.^2) sum(Xn.^3) sum(Xn.^4)]
                ]);
matrix_sum_y = [sum(Yn); sum(Xn.*Yn); sum((Xn.^2).*Yn)];
matrix_a = papa_matrice * matrix_sum_y;

Xk = linspace (-100,100,200);
Gk = matrix_a(3).*(Xk.^2) + matrix_a(2).*(Xk) + matrix_a(1);
dGk = 2*matrix_a(3).*(Xk.^1) + matrix_a(2);

max = find(abs(dGk) == min(abs(dGk)));

max_x = Xk(max);
max_y = Gk(max);

time = sqrt(2/9.8*max_y);
speed_y = 9.8*time;
speed_x = max_x/time; 

%% Plotting
figure
plot(Xn,Yn,Xk,Gk)
%plot(Xk,dGk)