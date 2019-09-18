%% Init
clear
clc

%% Calcul de déflection
m=88;
g = 9.8;
h=5;
k=6000;

poly_coeffs = [k/(2*m*g) -1 -5];

deflection = roots(poly_coeffs)