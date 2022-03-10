%% EÐL207G Verk 3
%% Inngangur
% Mikael Sævar Scheving Eggertsson 
%
% Torfi Þorgrímsson
%
% Leiðbeinandi: Unnar Bjarni Arnalds
%
% Framkvæmt 24.02.22 
% 
% Í tilrauninni var skoðað eiginleika straums og spennu í rafrásum með jafnspennu. Borið var saman viðnám í rað- og hliðtengdri rafrás. Ólínulegt viðnám ljósaperu var útreiknað og síðan borið saman við lögmál Stefan-Boltzmann um geislunarafl. Niðurstöðurnar stóðust við líkönin í öllum tilvikum.
%
%% 2 TILRAUN
format shortE
err = 0.01;
%% 2.1  
%%
% Spenna og straumur er mæld í rafrás (sem er tengd við spennu- og straummæli) við tvö tilfelli þegar hún er bæði raðtengd og hliðtengd. Frá þessum gildum er afl reiknað í báðum tilvikum og borið saman.
%% 
% <<C:\Users\torfi\Documents\Skoli\V2022\EDL207G\Verk3\2.1_vidnam_mynd.png>>
% 
%% _1 & 2_
% (1) $\frac{\Delta V}{V}=\frac{\Delta A}{A}=0.01$ 
AradTengt = 4.767e-3; % A Raðtengt
AradTengtErr = AradTengt*err;

VradTengt = 0.955; % V Raðtengt
VradTengtErr = VradTengt*err;

AhlidTengt = 16.590e-3; % A Hliðtengt
AhlidTengtErr = AhlidTengt*err;

VhlidTengt = 0.831; % V Hliðtengt
VhlidTengtErr = VhlidTengt*err;


AradTengtr     = round(AradTengt, 3,'significant');
AradTengtErrr  = round(AradTengtErr, 1,'significant');
VradTengtr     = round(VradTengt, 3,'significant');
VradTengtErrr  = round(VradTengtErr, 2,'significant');
AhlidTengtr    = round(AhlidTengt, 3,'significant');
AhlidTengtErrr = round(AhlidTengtErr, 1,'significant');
VhlidTengtr    = round(VhlidTengt, 3,'significant');
VhlidTengtErrr = round(VhlidTengtErr, 1,'significant');
tbl = ["" "Straumur[A]" "±[A]" "Spenna[V]" "±[V]" ; "Raðtengd" AradTengtr AradTengtErrr VradTengtr VradTengtErrr; "Hliðtengd" AhlidTengtr AhlidTengtErrr VhlidTengtr VhlidTengtErrr];
disp(tbl)
%% 
%% _3 & 4_
% (2) $R = V/I$
% 
% (3) $\Delta R = R*(\frac{\Delta V}{V}+\frac{\Delta A}{A})$
Rrad = VradTengt/AradTengt;
RradErr = Rrad*2*err;
Rhlid = VhlidTengt/AhlidTengt;
RhlidErr = Rhlid*2*err;

%%
% Líkan:
% 
% (4) Raðtengt
%  $R_{tot} = R_{1} + R_{2}$
% 
% (5) Hliðtengt
%  $R_{tot} = \frac{1}{R_{1}} + \frac{1}{R_{2}}$
RradMdl = 100 + 100;
RhlidMdl = (100*100)/(100+100);

Rradr     = round(Rrad, 1,'significant');
RradErrr  = round(RradErr, 1,'significant');
Rhlidr    = round(Rhlid, 1,'significant');
RhlidErrr = round(RhlidErr, 1,'significant');
tbl = ["" "Mælt viðnám" "±" "útreiknað viðnám" ; "Raðtengd" Rradr RradErrr RradMdl; "Hliðtengd" Rhlidr RhlidErrr RhlidMdl];
disp(tbl)
%% 
%% _5_
% (6) $P = IV$
% 
% (7) $\Delta P = P*(\frac{\Delta V}{V}+\frac{\Delta A}{A})$
Wrad = AradTengt*VradTengt;
WradErr = Wrad*err*2;
Whlid = AhlidTengt*VhlidTengt;
WhlidErr = Whlid*err*2;

Wradr     = round(Wrad, 3,'significant');
WradErrr  = round(WradErr, 1,'significant');
Whlidr    = round(Whlid, 3,'significant');
WhlidErrr = round(WhlidErr, 1,'significant');
tbl = ["" "Afl" "±" ; "Raðtengd" Wradr WradErrr; "Hliðtengd" Whlidr WhlidErrr];
disp(tbl)
%%
% Út frá mælingum sjáum við að það er mun meira afl í hliðtengdu rásinni.


%% 2.2
%%
% Ljósapera er tengd við spennugjafa ásamt spennu- og straummæli. Út frá lögmáli ohms er R0 mælt. Tilraunin er endurtekinn 8 sinnum á bilunum frá 1V - 8V.
% 
% <<C:\Users\torfi\Documents\Skoli\V2022\EDL207G\Verk3\2.2_ljos_mynd.png>>
% 
% V inn: 0,1,2,3,4,5,6,7,8 [V]
%
% #
%
V = [10.6e-3,0.480,1.229,2.130,3.081,4.03,5.00,5.97,6.95];
A = [2.983,50.51,80.95,109.38,134.34,156.12,176.07,194.39,211.51]*1e-3;
R = V./A;
Verror = (zeros(1,length(V))+1).*err.*V;
Aerror = (zeros(1,length(A))+1).*err.*A;
Rerror = (zeros(1,length(R))+1).*err*2.*R;

Vr = round(V, 3,'significant');
Ar = round(A, 3,'significant');
Rr = round(R, 3,'significant');
Verrorr = round(Verror, 1,'significant');
Aerrorr = round(Aerror, 1,'significant');
Rerrorr = round(Rerror, 1,'significant');

tbl = ["V[V]" "±[V]" "I[A]" "±[A]" "R[Ohm]" "±[Ohm]" ; Vr.' Verrorr.' Ar.' Aerrorr.' Rr.' Rerrorr.'];
disp(tbl)

fig = figure(1);
errorbar(V,R,Rerror,Rerror,Verror,Verror)
xlabel('Spenna V')
ylabel('Viðnám Ohm')
%%
% Frá niðurstöðum sést augljóslega að viðnám er háð spennu. 
%% 2.3

%%
% Notað eru mælingarnar úr tilraun 2.2 til að ákvarða hitastig ljósaperunar með jöfnu (8). Frá viðnámi, þvermáli vírsins, og eðlisviðnám wolframs er ákvarðað yfirborðsflatarmál og lengd vírsins með jöfnu (11). Síðan er yfirborðsflatarmálið, hitastig og Stefan-Boltzmann fastinn notaðir til að ákvarða eðlisgeislun yfirborðs Wolfram út frá Stefan-Boltzmann jöfnunni (10).
%% _1_
%
% (8) $T= \frac{R/R_{0}-1}{\alpha}+T_{0}$
%
% (9) $\Delta T = T * (\frac{\Delta R}{R} + \frac{\Delta R_{0}}{R_{0}})$
P = A.*V;
alpha = 4.40e-3;
T0 = 22.6+273.15;
T = (R.*R(1)^-1-1)*alpha^-1 + T0;
T4 = T.^4;
Terror = T.*(Rerror.*R.^-1+Rerror(1).*R(1).^-1);
T4error = 4*T4.*Terror.*T.^-1;
Perror = (zeros(1,length(P))+1).*err*2.*P;


Pr = round(P, 2,'significant');
Tr = round(T, 2,'significant');
%T4 = round(T4, 2,'significant');
T4r = [];
for i=1:length(T4)
    T4r = [T4r string(sprintf('%0.1e', T4(i)))];
end
Terrorr = round(Terror, 1,'significant');
%T4error = round(T4error, 2,'significant');
T4errorr = [];
for i=1:length(T4error)
    T4errorr = [T4errorr string(sprintf('%0.1e', T4error(i)))];
end
Perrorr = round(Perror, 1,'significant');

tbl = ["Afl[W]" "±[W]" "Hiti[K]" "±[K]" "Hiti^4[K^4]" "±[K^4]"; Pr.' Perrorr.' Tr.' Terrorr.' T4r.' T4errorr.'];
disp(tbl)

%% _2_
fig = figure(1);
errorbar(T4,P,Perror,Perror,T4error,T4error)
xlabel("T^{4} K")
ylabel("Afl W")
%%
%% _3_
%
%%


%%
% Fastar:
%
% $\alpha = 4.40e-3K^{-1}$
% 
% $\alpha$ er stuðull sem lísir hvernig viðnám breitist með hita stigi
%
% $D =  30 \mu m$
% 
% $D$ er þvermál ljósaperuvírsins 
%
%
% $\sigma = 5.67e-8 Wm^2 K^{-4}$
%
% $\sigma$ er Stefan-Boltzmann fastinn
% 
% $\rho = 5.6e-8$
%
% $\rho$ er eðlisviðnám perunnar 
%%
% Líkan:
% 
% (10) $S= \frac{R_{0} \pi ^2 D^3}{4 \rho}$
%
% (11) $\Delta S = S*(\frac{ \Delta R_{0}}{R_{0}})$
% 
% $S$ er yfirborðsflatarmál vírsins

%%
%
S = (R(1)*pi^2*D^3)*(4*rhoW)^-1
Serror = S*Rerror(1)*R(1)^-1
%%
%
% (12) $P= \sigma \epsilon ST^4$
% 
% $P$ er afl notkun perunar, reiknað með lögmál Ohms
% 
% (13) $\Delta h = h * (\frac{\Delta y_{a}+\Delta y_{b}}{y_{b}}+\frac{\Delta x_{a}+\Delta x_{b}}{x_{b}})$
%
% Hallatalan ($h$) er fyrir $P$ sem fall af $T^4$
%

%%
%
h = polyfit(T4,P,1);
h = h(1)
hError = h*((T4error(1)+T4error(9))/(T(9)^4)+(Perror(1)+Perror(9))/P(9))
%%
% $\epsilon$ er eðlisgeislun Wolfram
%

D = 30e-6;
rhoW = 5.6e-8;

sigma = 5.670367e-8;

epsilon = h*sigma^-1*S^-1
epsilonError = epsilon*(hError/h+Serror/S)


close(fig)

%% 
%% Niðurstöður 
%
% Í tilraun 2.1 sést augljóslega að það er meiri spenna í hliðtengdu en í raðtengdu, meira að segja langt innann skekkjumarka. Sú niðurstaða fylgir líkaninu fyrir hliðtengdum og raðtengdum rafrása. 
%
% Grafið úr mælingunum og útreikningunum í tilraun 2.2 sýnir klárlega að viðnámið er vel háð spennunni sem er lögð í gegnum peruna, viðnámið var ekki línulegt sem var átt von á. 
%
% Í tilraun 2.3 heppnuðust útreikningar á yfirborðsflatarmáli vírsins frekar vel með aðeins 2% óvissu. Hins vegar voru niðurstöðurnar um eðlisgeislun með mun stærri óvissu um  20%, því óvissan er svo stór að það er ekki hægt að taka mikil mörk á henni. 
%
