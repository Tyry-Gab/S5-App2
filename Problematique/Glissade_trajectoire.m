%% Init
clc
clear
close all
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

X = linspace(0,25);
glissade = a(1) + a(2).*X.^1 + a(3).*X.^2 + a(4).*X.^3 + a(5).*X.^4; 
He = a(1) + a(2)*Xe^1 + a(3)*Xe^2 + a(4)*Xe^3 + a(5)*Xe^4;

derive = a(2)*Xe^0 + 2*a(3)*Xe^1 + 3*a(4)*Xe^2 + 4*a(5)*Xe^3;
%% Plotting
figure
plot(X,glissade)
title('Trajectoire de la glissade')
hold on 
scatter(Xn,Yn)
xlabel("Position horizontale (m)")
ylabel("Position verticale (m)")

%% Friction less cum speed
masse = 80;
g = 9.8;
Loss_pot_energy = masse*g*(30-He);

friction_less_speed = sqrt(2*Loss_pot_energy/masse);

%% Valve

Ouverture = [0 10 20 30 40 50 60 70 80 90 100];
Coefficient = [0.87 0.78 0.71 0.61 0.62 0.51 0.51 0.49 0.46 0.48 0.46];
o_lineaire = linspace(0,100,1000);
poly_order = 1:1:numel(Ouverture);
rms_values = ones(numel(Ouverture),1);
m=0;


figure
title('Coefficients pour la valve')
hold on
legend
for m=poly_order
    P_poly = ones(numel(Ouverture),m);
    for i=2:m
        P_poly(:,i) = Ouverture.^(i-1);
    end
    
    a_poly = inv(P_poly'*P_poly)*P_poly'*Coefficient';
    y_linear_poly = polyval(flip(a_poly),o_lineaire);
    
    
    values = polyval(flip(a_poly),Ouverture);
    rms_values(m)= sqrt(1/numel(y_linear_poly)*sum((values-Coefficient).^2));
    plot(o_lineaire,y_linear_poly,'DisplayName',sprintf("Ordre %d",m-1)) 
end


figure
hold on
title("RMS des différents polynomes selon lerur ordre")
scatter(poly_order-1,rms_values)
xlabel("Ordre des pôlynomes")
ylabel("RMS")


m=7;
P_poly = ones(numel(Ouverture),m);
    for i=2:m
        P_poly(:,i) = Ouverture.^(i-1);
    end
    
a_poly = inv(P_poly'*P_poly)*P_poly'*Coefficient';
y_linear_poly = polyval(flip(a_poly),o_lineaire);
rms = rms_values(7);

figure
hold on
text(70,0.8,sprintf("RMS: %d",rms))
scatter(Ouverture,Coefficient)
plot(o_lineaire,y_linear_poly)
    
    
%OP = XPlotty(find(abs(McPlotty-target_coeff) < 0.0003));
%% Finding coefficent

target_speed = 22.5/3.6;
Friction_work = masse*g*(He-30) + 0.5*masse*(target_speed^2-0);
target_coeff = -Friction_work/(masse*g*(Xe-0));

%% Speed per distance
m = 80;
g = 9.8;
x = linspace(0,25);
%T = Vg - F;
v = 3.6.*sqrt(2*(m.*g.*(30 - glissade) - target_coeff.*m.*g.*x)./m);
%v = 3.6.*sqrt(2*(m.*g.*(30 - glissade))/m);

figure
title('Vitesse selon la trajectoire')
hold on
plot(x,glissade)
plot(x,v)
legend("glissade","vitesse (km/h)")

max_speed = max(v);

%% Timer for plastic collision

v_plastic = (m*v(100)/3.6 - 8)/(m+8);
t_plastic = 3/v_plastic;


%% Timer for elastic collision
e = 0.8;
v2 = -1;
Q_final = e*(v(100)/3.6 + 1);

v_elastic = -(Q_final*8 -80*v(100)/3.6 + 8)/(88);
t_elastic = 3/v_elastic;

%% Timer 
timer = (t_elastic + t_plastic)/2;




