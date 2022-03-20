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
k = (R+innraVid)*C
slope = polyfit(v_r, t, 1);
slope = slope(1)
v_rerror = v_r.*err;
terrror = t.*err;
figure
errorbar(t,v_r,v_rerror,v_rerror,terrror,terrror);


%% 3.3
R = 110;
L = 10e-3;

t = [16 48 79.5 112 142 173.5 204.5 236.5]*1e-6;
v_r = [0.576 -0.432 0.328 -0.24 0.176 -0.128 0.096 -0.072];
figure
plot(t,v_r)

R = 110;
e = 2.71828;
x = linspace(0, 250e-5);
b = R/(2*L)
omega_0 = (1/L*C)^0.5
omega_e = (omega_0^2-b^2)^0.5
%mdl = v_r(2).*(omega_e.*L).^-1.*e.^-(b.*x).*sin(omega_e.*x);
%plot(x,mdl)

figure
plot(t,1:0.5:4.5)

n = 1:0.5:4.5;
mesOmega_e = 2*pi./t.*(n+1/4)