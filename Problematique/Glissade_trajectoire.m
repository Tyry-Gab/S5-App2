%% Init
clc
clear

%% The gud stuf

Xn = [0 8 15 20  24];
Yn = [30 19 20 16 12.5];
Xe = 25;

papa_matrice = inv([
                [numel(Xn) sum(Xn) sum(Xn.^2) sum(Xn.^3) sum(Xn.^4)];
                [sum(Xn.^1) sum(Xn.^2) sum(Xn.^3) sum(Xn.^4) sum(Xn.^5)];
                [sum(Xn.^2) sum(Xn.^3) sum(Xn.^4) sum(Xn.^5) sum(Xn.^6)];
                [sum(Xn.^3) sum(Xn.^4) sum(Xn.^5) sum(Xn.^6) sum(Xn.^7)];
                [sum(Xn.^4) sum(Xn.^5) sum(Xn.^6) sum(Xn.^7) sum(Xn.^8)]
               ]);
matrice_y = [sum(Yn); sum(Yn.*Xn); sum(Yn.*Xn.^2); sum(Yn.*Xn.^3); sum(Yn.*Xn.^4)];

a = papa_matrice * matrice_y;

X = linspace(0,30,10000000);
glissade = a(1) + a(2).*X.^1 + a(3).*X.^2 + a(4).*X.^3 + a(5).*X.^4; 
He = a(1) + a(2)*Xe^1 + a(3)*Xe^2 + a(4)*Xe^3 + a(5)*Xe^4;

derive = a(2)*Xe^0 + 2*a(3)*Xe^1 + 3*a(4)*Xe^2 + 4*a(5)*Xe^3;
%% Plotting
figure
plot(X,glissade)
hold on 
scatter(Xn,Yn)

%% Friction less cum speed
masse = 80;
g = 9.8;
Loss_pot_energy = masse*g*(30-He);

friction_less_speed = sqrt(2*Loss_pot_energy/masse);

%% Valve

Ouverture = [0 10 20 30 40 50 60 70 80 90 100];
Coefficient = [0.87 0.78 0.71 0.61 0.62 0.51 0.51 0.49 0.46 0.48 0.46];

phi = [ones(1,numel(Ouverture)); Ouverture; Ouverture.^2; Ouverture.^3; Ouverture.^4; Ouverture.^5; Ouverture.^6; Ouverture.^7; Ouverture.^8]';
A = inv(phi' * phi) * phi' * Coefficient';

XPlotty = linspace(0,100);
McPlotty = A(1).*XPlotty.^0 + A(2).*XPlotty.^1 + A(3).*XPlotty.^2 + A(4).*XPlotty.^3 + A(5).*XPlotty.^4 + A(6).*XPlotty.^5 + A(7).*XPlotty.^6 + A(8).*XPlotty.^7 + A(9).*XPlotty.^8;


figure
hold on
scatter(Ouverture,Coefficient)
plot(XPlotty,McPlotty)

values = A(1).*Ouverture.^0 + A(2).*Ouverture.^1 + A(3).*Ouverture.^2 + A(4).*Ouverture.^3 + A(5).*Ouverture.^4 + A(6).*Ouverture.^5 + A(7).*Ouverture.^6 + A(8).*Ouverture.^7 + A(9).*Ouverture.^8;
RMS = sqrt(1/numel(McPlotty)*sum((values-Coefficient).^2));
%% Finding coefficent







