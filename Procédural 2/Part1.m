%% Init
clc
clear

%% Base values

t = [2 3 4 5 6 7 8 10 12 15];
y = [2.11 1.61 1.25 0.82 0.737 0.81 0.88 0.443 0.07 -0.493];
N = numel(t);
matrice_y = y';

OrdrePolynome = [N N-2 N-3 N-4];

t_line = linspace(0,15,150);

%% N = 3
phi_3 = [ones(1,numel(t)); t; t.^2]';
a_3 = inv(phi_3' * phi_3) * phi_3' * matrice_y
interpolation_3 = a_3(1) + a_3(2).*t_line + a_3(3).*t_line.^2;

%% N = 4
phi_4 = [ones(1,numel(t)); t; t.^2; t.^3]';
a_4 = inv(phi_4' * phi_4) * phi_4' * matrice_y
interpolation_4 = a_4(1) + a_4(2).*t_line + a_4(3).*t_line.^2 + a_4(4).*t_line.^3;

%% N = 5
phi_5 = [ones(1,numel(t)); t; t.^2; t.^3; t.^4 ]';
a_5 = inv(phi_5' * phi_5) * phi_5' * matrice_y
interpolation_5 = a_5(1) + a_5(2).*t_line + a_5(3).*t_line.^2 + a_5(4).*t_line.^3 + a_5(5).*t_line.^4;

%% N = 6
phi_6 = [ones(1,numel(t)); t; t.^2; t.^3; t.^4; t.^5]';
a_6 = inv(phi_6' * phi_6) * phi_6' * matrice_y
interpolation_6 = polyval(flip(a_6),t_line);

%% N = 7
phi_7 = [ones(1,numel(t)); t; t.^2; t.^3; t.^4; t.^5; t.^6]';
a_7 = inv(phi_7' * phi_7) * phi_7' * matrice_y
interpolation_7 = polyval(flip(a_7),t_line);

%% N = 8
phi_8 = [ones(1,numel(t)); t; t.^2; t.^3; t.^4; t.^5; t.^6; t.^7]';
a_8 = inv(phi_8' * phi_8) * phi_8' * matrice_y
interpolation_8 = polyval(flip(a_8),t_line);

%% N = 10
phi_10 = [ones(1,numel(t)); t; t.^2; t.^3; t.^4; t.^5; t.^6; t.^7; t.^8; t.^9]';
a_10 = inv(phi_10' * phi_10) * phi_10' * matrice_y
interpolation_10 = polyval(flip(a_10),t_line);

%% Plotting 


figure
hold on
scatter(t,y)
plot(t_line,interpolation_6)
plot(t_line,interpolation_7)
plot(t_line,interpolation_8)
plot(t_line,interpolation_10)
legend("base points", "M=6", "M=7", "M=8", "M=10")