%% verk 2
%% 2.1
% u = frá peru
% e = frá spegil
rulerror = 1
u1 = 10.3e1 %mm
u2 = 8.35e1
u3 = 7.5e1
e1 = 10.2e1
e2 = 8.4e1
e3 = 7.4e1

syms f1 f2 f3;
f1 = solve(1/u1-1/e1 == 1/f1, f1)
f2 = solve(1/u2-1/e2 == 1/f2, f2)
f3 = solve(1/u3-1/e3 == 1/f3, f3)
f1err = f1*(rulerror/u1 + rulerror*3/e1)
f2err = f2*(rulerror/u2 + rulerror*3/e2)
f3err = f3*(rulerror/u3 + rulerror*3/e3)
%% 
% f á að nálgast óendanlegt

%% 2.2
% 
f = 2.8e1 %mm
R = 2*f
Rerror = rulerror*2


%% 2.3
degErr = 2*pi/180;
utDegPlan = ([   180 190 200 210 220 230 240 250 260 270  ]-180)*pi/180
innGsli =      [ 0   6   13  20  25  31  35  39  41  42  ]*pi/180

errInnGsli = degErr*cos(innGsli)
erroutplan = degErr*cos(utDegPlan)

errorbar(sin(utDegPlan), sin(innGsli), errInnGsli, errInnGsli, erroutplan, erroutplan); hold on;
xlabel("Sin \theta_{inn}")
ylabel("Sin \theta_{ut}")

slope = polyfit(sin(utDegPlan), sin(innGsli),1);
slope = slope(1)
slopeErr = slope*((errInnGsli(1)-errInnGsli(10))/(-innGsli(1) + innGsli(10))+(erroutplan(1)-erroutplan(10))/(-utDegPlan(1) + utDegPlan(10)))

n2 = slope