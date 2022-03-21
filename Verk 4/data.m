%% EÐL207G Verk 4
err = 0.01;
%% 3.1
innraVid = 53; %ohm


%% 3.2
%% _1-3_
v_r = 0.6047; %volt
%% _4_
R = 5e3;
C = 10e-9;

v_r = [2.88 2.4 1.6 1.08 0.72 0.48 0.36 0.24];
t = [0 10 30 50 70 90 110 130]*1e-6;
k = 1/((R+innraVid)*C)
slope = polyfit(v_r, t, 1);
slope = slope(1)
v_rerror = v_r.*err;
terrror = t.*err;

kMes = (log(v_r(1))-log(v_r)).*t.^-1
kMesErr = 1./(t.*v_r).*v_rerror+(log(v_r(1))-log(v_r))./t.^2.*terrror
tau = 1./kMes
figure(1)
errorbar(t,v_r,v_rerror,v_rerror,terrror,terrror); hold on;
x = linspace(0, 150e-6, 100);
mdl = v_r(1)*exp(-k.*x);
plot(x,mdl)
hold off;

xlabel('[s]')
ylabel('[V]')
legend('Mælt', 'V_0e^{-kt}')

%% 3.3
%% _1_
R = 110;
L = 10e-3;

t = [16 48 79.5 112 142 173.5 204.5 236.5]*1e-6;
v_r = [0.576 -0.432 0.328 -0.24 0.176 -0.128 0.096 -0.072];
terror = t.*err;
v_rerror = v_r.*err;

figure(2);

errorbar(t,v_r, v_rerror,v_rerror,terror,terror); 

t_mdl = linspace(0,2.4e-4,1e5);
b = R/(2*L)

R = 110;
omega_0 = ((1/(L*C))^0.5)
omega_e = (omega_0^2-b^2)^0.5


syms A l;
eq1 = A*exp(-l*t(1))*sin(omega_0*t(1)) == v_r(1);
eq2 = A*exp(-l*t(7))*sin(omega_0*t(7)) == v_r(7);
Andl = solve([eq1 eq2], [A l]);
lambda = double(Andl.l)
A = double(Andl.A)

f2  = @(p) p(1) * sin(p(2) * t_mdl - p(3)) .* exp(-p(4) * t_mdl);
%      v_r(1)*1.19                      b*1.7
p20 = [A            omega_0     0   lambda]

hold on;
plot(t_mdl, f2(p20));
hold off;

xlabel('[s]')
ylabel('[V]')
legend('Mælt', 'Best fit, for p(1)&p(7)')

%% _2_
n = 0:0.5:3.5;
x0 = linspace(0, 3e-4);
y0 = polyval(polyfit(t,n,1), x0);
figure(3)
errorbar(t,n,zeros(1,8),zeros(1,8),terror,terror); 
hold on;
plot(x0,y0,'r--', 'LineWidth', 0.1)
hold off;

xlabel('[s]')
ylabel('[n]')
legend('Mælt', 'Best fit')

n = 1:0.5:4.5;
mesOmega_e = 2*pi./t.*(n+1/4)