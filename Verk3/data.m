%% EÐL207G Verk 3
% Lögmál Ohm og geislunarafl ljósaperu
%% 2 TILRAUN
format shortE
err = 0.01;
%% 2.1  
%% _1 & 2_
AradTengt = 4.767e-3; % A Raðtengt
AradTengtErr = AradTengt*err;
%%
VradTengt = 0.955; % V Raðtengt
VradTengtErr = VradTengt*err;
%%
AhlidTengt = 16.590e-3; % A Hliðtengt
AhlidTengtErr = AhlidTengt*err;
%%
VhlidTengt = 0.831; % V Hliðtengt
VhlidTengtErr = VhlidTengt*err;
%%
% Rað tengd viðnám
tblrad = ["Straumur" AradTengt "+-" AradTengtErr ; "Spenna" VradTengt "+-" VradTengtErr]

%%
% Hlið tengd viðnám
tblhlid = ["Straumur" AhlidTengt "+-" AhlidTengtErr ; "Spenna" VhlidTengt "+-" VhlidTengtErr]

%% 
%% _3 & 4_
Rrad = VradTengt/AradTengt;
RradErr = Rrad*2*err;
Rhlid = VhlidTengt/AhlidTengt;
RhlidErr = Rhlid*2*err;

RradMdl = 100 + 100;
RhlidMdl = (100*100)/(100+100);
tbl = ["" "Mælt viðnám" "Óvissa" "útreiknað viðnám" ; "Rað Tengd" Rrad RradErr RradMdl; "Hlið Tengd" Rhlid RhlidErr RhlidMdl]
%% 
%% _5_
Wrad = AradTengt*VradTengt;
WradErr = Wrad*err*2;
Whlid = AhlidTengt*VhlidTengt;
WhlidErr = Whlid*err*2;
tbl = ["" "Afl" "Óvissa" ; "Rað tengd" Wrad WradErr; "Hlið tengd" Whlid WhlidErr]
%%
% meira í hliðtengdu

%% 2.2
% volt plan 0,1,2,3,4,5,6,7,8
V = [10.6e-3,0.480,1.229,2.130,3.081,4.03,5.00,5.97,6.95];
A = [2.983,50.51,80.95,109.38,134.34,156.12,176.07,194.39,211.51]*1e-3;
R = V./A;
Verror = (zeros(1,length(V))+1).*err.*V;
Aerror = (zeros(1,length(A))+1).*err.*A;
Rerror = (zeros(1,length(R))+1).*err*2.*R;

tbl = ["Spenna" "Óvissa" "Straumur" "Óvissa" "Viðnám" "Óvissa" ; V.' Verror.' A.' Aerror.' R.' Rerror.']

fig = figure(1);
errorbar(V,R,Rerror,Rerror,Verror,Verror)
xlabel('Spenna V')
ylabel('Viðnám Ohm')
%%
% Nei, viðnám er háð spennu
%% 2.3
%% _1_
P = A.*V;
alpha = 4.40e-3;
T0 = 22.6+273.15;
T = (R.*R(1)^-1-1)*alpha^-1 + T0;
T4 = T.^4;
Terror = 1 + T.*(Rerror.*R.^-1+Rerror(1).*R(1).^-1);
T4error = 4*T4.*Terror.*T.^-1;
Perror = (zeros(1,length(P))+1).*err*2.*P;
tbl = ["Afl" "Óvissa" "Hiti" "Óvissa" "Hiti^4" "Óvissa"; P.' Perror.' T.' Terror.' T4.' T4error.']
%%
%% _2_
fig = figure(1);
errorbar(T4,P,Perror,Perror,T4error,T4error)
xlabel("T^{4} K")
ylabel("Afl W")
%%
%% _3_
slope = polyfit(T4,P,1);
slope = slope(1)
%%

blbDiam = 30e-6
rhoW = 5.6e-8

S = (R(1)*pi^2*blbDiam^3)*(4*rhoW)^-1
%%
steffBoltz = 5.670367e-8

epsilon = slope*steffBoltz^-1*S^-1
%%
slopeError = slope*((T4error(1)+T4error(9))/(T(9)^4)+(Perror(1)+Perror(9))/P(9))
%%
Serror = S*Rerror(1)*R(1)^-1
%%
epsilonError = epsilon*(slopeError/slope+Serror/S)
%%

close(fig)

options.format = 'pdf';
options.showCode = false;