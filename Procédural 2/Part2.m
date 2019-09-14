%% Init
clc
clear

%% Initial values
t = [0.0 1.0 2.0 3.0 4.0 5.0];
y = [0.0 2.608 1.350 -1.909 -2.338 0.6988];

w = 2*pi/4.8;
x_linear = linspace(0,5);
%% With polynome

poly_order = 1:1:numel(t);
figure(1)
hold on
scatter(t,y)
for m=6
    P_poly = ones(numel(t),m);
    for i=2:m
        P_poly(:,i) = t.^(i-1);
    end
    a_poly = inv(P_poly'*P_poly)*P_poly'*y';
    
    
    y_linear_poly = polyval(flip(a_poly),x_linear);
    plot(x_linear,y_linear_poly)
end


%% With sinus and cosinus
P_sine = [cos(w.*t); sin(w.*t); cos(2.*w.*t); sin(2.*w.*t); cos(3.*w.*t); sin(3.*w.*t)]';
a_sine = inv(P_sine'*P_sine)*P_sine'*y';
y_linear_sine = a_sine(1).*cos(w.*x_linear) + a_sine(2).*sin(w.*x_linear) + a_sine(3).*cos(2.*w.*x_linear) + a_sine(4).*sin(2.*w.*x_linear) + a_sine(5).*cos(3.*w.*x_linear) + a_sine(6).*sin(3.*w.*x_linear);

figure(1)
plot(x_linear,y_linear_sine)

%% Exponential
c =10;
coeff = 1;
init = ones(1,numel(t));
for m=poly_order
    if mod(m,(2) == 1)
        coeff = coeff + 1;
    end
    P_exp(m,:)= exp(coeff.*t./c.*((-1).^(m-1)));
end
P_exp = P_exp';
a_exp = inv(P_exp'*P_exp)*P_exp'*y';

y_linear_exp = 0;

coeff = 1;
for i=poly_order
    if mod(m,(2) == 1)
        coeff = coeff + 1;
    end
    y_linear_exp = y_linear_exp + a_exp(i).*exp(coeff.*x_linear./c.*((-1).^(i-1)));
    
end

figure(1)
plot(x_linear,y_linear_exp)

%%  




