%% Init
clc
clear
close all



%% Numero 1
m=4;
h = 0.6;
k = 20000;
g=9.8;

Vg = m*g*h;

v = sqrt(Vg/(0.5*m));

compression = sqrt(Vg/(0.5*k));


%% Numero 2

e = 0.95;
v1 = 5*sin(deg2rad(30));
v2 = 0;

v1_prime = (v2 + v1 - e*(v1-v2))/2;
v2_prime = v1 + v2 - v1_prime;

%% Numero 3

x = [0.0 0.1 0.2 0.3 0.4 0.5]';
F = [12.5 170 207.5 185 162.5 200]';
x_linear = linspace(0,0.5,1000);
m = 1687.5;
Order = 1:1:numel(x);


figure
hold on
scatter(x,F,'DisplayName','Valeurs de base')
for i=Order
   g_x = 0;
   for n=1:i
       P(:,i) = x.^(n-1);
   end
   
   a = inv(P'*P)*P'*F;
   
 
   values = 0;
   integrale_analytique = 0;
   for q=1:i
      g_x = g_x + a(q).*x_linear.^(q-1);
      values = values + a(q).*x.^(q-1);
   end
    
   RMS(i) = sqrt(1/numel(g_x) * sum( (values-F).^2) );
   F_barre = numel(F)^-1*sum(F);
   R(i) = ( sum( (values-F_barre).^2 ))/(sum( (F-F_barre).^2) );
   plot(x_linear,g_x,'DisplayName',sprintf("Ordre %d",i))
end
legend








