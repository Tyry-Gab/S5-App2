%% Init
clear
clc

%% the good stuff
tn = [2 3 4 6 7 8 10 11 12 15];
yn = [2.11 1.61 1.25 0.820 0.737 0.810 0.880 0.443 0.070 -0.493];
w = 2*pi/8;
N = numel(tn);
papa_matrice = inv([
                [N sum(tn) sum(cos(w.*tn)) sum(sin(w.*tn))];
                [sum(tn) sum(tn.^2) sum(tn.*cos(w.*tn)) sum(tn.*sin(w.*tn))];
                [sum(cos(w.*tn)) sum(cos(w.*tn).*tn) sum(cos(w.*tn).^2) sum(cos(w.*tn).*sin(w.*tn))];
                [sum(sin(w.*tn)) sum(sin(w.*tn).*tn) sum(sin(w.*tn).*cos(w.*tn)) sum(sin(w.*tn).^2)]
               ])
matrix_y = [sum(yn); sum(tn.*yn); sum(cos(w.*tn).*yn); sum(sin(w.*tn).*yn)]

a = papa_matrice * matrix_y

t = linspace(0,15,1000);
test = a(1) + a(2).*t + a(3).*cos(w.*t) + a(4).*sin(w.*t);
res = 1.9998 - 0.1538.*t + 0.1074*cos(w.*t) + 0.3434*sin(w.*t);
%% Ploting
plot(tn,yn,t,res,t,test)

%% RMS
values = 1.9998 - 0.1538.*tn + 0.1074*cos(w.*tn) + 0.3434*sin(w.*tn);
papa_rms = sqrt(1/numel(res)*sum((values-yn).^2));

y_barrre = 1/numel(tn)*sum(yn);

R = sum((values-y_barrre).^2)/sum((yn-y_barrre).^2)


%% More good stuff


