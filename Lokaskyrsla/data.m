%% EÐL207G
%% pure data
u = symunit;
nm = double(separateUnits(unitConvert(u.nm, u.m)));
cm = double(separateUnits(unitConvert(u.cm, u.m)));
mm = double(separateUnits(unitConvert(u.mm, u.m)));
uA = double(separateUnits(unitConvert(u.uA, u.A)));

rulercmW = 705; % 8cm -29cm = 21cm
pix2mm = rulercmW/2100*mm;
%% tilraun 1
findMidl1 = @(p) p(ceil(end/2));
cntr1pix2mm = @(p) (p-findMidl1(p))*pix2mm;

tilraun1 = [62 255 374 490 682];
tilraun1 = cntr1pix2mm(tilraun1)

err = (1*mm + pix2mm)*ones(1,5);

%% tilraun 2
findMidl2 = @(p) (p(end/2)+p(end/2+1))/2;
cntr2pix2mm = @(p) (p-findMidl2(p))*pix2mm;

tilraun2_025 = [266 293 320 346 376 400 427 454];
tilraun2_025 = cntr2pix2mm(tilraun2_025)
%%
tilraun2_05 = [327 342 356 369 382 395];
tilraun2_05 = cntr2pix2mm(tilraun2_05)
%% trash
tilraun2_075 = [235 279 326 406 448 493];
tilraun2_075 = cntr2pix2mm(tilraun2_075)
%%
tilraun2_1 = [172 221 270 371 421 468];
tilraun2_1 = cntr2pix2mm(tilraun2_1)

tilraun2 = {tilraun2_025', tilraun2_05' , tilraun2_075' , tilraun2_1'}

%% tilraun 3
tilraun3 = [59 159 259 456 553 648];
tilraun3 = cntr2pix2mm(tilraun3)

%% tilraun 4
degMarker = 0:10:180;
tilraun4 = [109.08 78.6 50.15 26.72 10.38 3.16 5.4 17.79 38.97 64.81 95.38 121.48 164.36 164.14 171 169.45 157.37 138.72 112.17]*uA;

%% Tilraun 1 útreikningar

L = 9*cm;
Lerr = 0.1*cm;
d = 1880*nm;

n = -2:2;
% skrifað
% x_n = [ 9.1	3.55	0	-3.5	-9.3 ]*cm;
% x_nerr = 0.05*cm;

% pixle mælt-
slopeError = @(z,w,zerr,werr) -polyfit([z(1)-zerr(1) z(end)+zerr(end)],[w(1)+werr(1) w(end)-werr(end)],1) + polyfit([z(1)+zerr(1) z(end)-zerr(end)],[w(1)-werr(1) w(end)+werr(end)],1);

sin_thFind = @(x,l) x.*(l^2 +x.^2).^-0.5;
sin_therrFind = @(x,l,xerr,lerr) l*(l^2*lerr^2+x.^2.*xerr.^2).^0.5.*(x.^2+l^2).^-1.5;


sin_th = sin_thFind(tilraun1,L)
sin_therr = sin_therrFind(tilraun1,L,err,Lerr)

figure
errorbar(-2:2, sin_th,sin_therr,sin_therr,zeros(1,5),zeros(1,5))

xlabel("Bylgju toppa númer [n]")
ylabel('sin \theta')

b = abs([sin_th(1)-sin_th(5) 	sin_th(2)-sin_th(4)])
c = [4 						2 ];
berr = [(sin_therr(1)^2+sin_therr(5)^2)^0.5 (sin_therr(2)^2+sin_therr(4)^2)^0.5];
hrough = d*b./c
hrougherr = d./c.*berr

htrue = polyfit(n, d*sin_th, 1);
htrue = htrue(1)
htrueerr = slopeError(n,d*sin_th,zeros(1,5), d*sin_therr)

lambda = d.*sin_th./n
lambdaerr = d./n.*sin_therr


%%
% hrough er best

lambda = hrough(1);
lambdaerr = hrougherr(1);


%% Tilraun 2 útreikningar

L = 310*cm;
Lerr = 0.5*cm;


drough = zeros(1,4);
drougherr = zeros(1,4);

c = [8 6 6 6]

for index = 1:4
	sin_k = sin_thFind(tilraun2{index},L)
	sin_kerr = sin_therrFind(tilraun2{index}, L,(1*mm + pix2mm)*ones(length(tilraun2{index}),1),Lerr)
	b = sin_k(end) - sin_k(1)
	berr = (sin_kerr(1)^2+sin_kerr(end)^2)^0.5
	drough(index) = lambda/(b/c(index));
	drougherr = drough*(berr/b);
end

sinerrr = sin_therrFind(tilraun2{1}, L,(1*mm + pix2mm)*ones(length(tilraun2{1}),1),Lerr);
figure
errorbar(-3.5:3.5,sin_thFind(tilraun2{1},L),sinerrr,sinerrr,zeros(1,8),zeros(1,8))
xlabel("Bylgju toppa númer [n]")
ylabel('sin \theta')

sinerrr = sin_therrFind(tilraun2{2}, L,(1*mm + pix2mm)*ones(length(tilraun2{2}),1),Lerr);
figure
errorbar(-2.5:2.5,sin_thFind(tilraun2{2},L),sinerrr,sinerrr,zeros(1,6),zeros(1,6))
xlabel("Bylgju toppa númer [n]")
ylabel('sin \theta')


drough
drougherr


%% tilraun 3 útreikningar

sin_th = sin_thFind(tilraun3,L);
sin_therr = sin_therrFind(tilraun3,L,(1*mm + pix2mm)*ones(1,length(tilraun3)),Lerr);
b = sin_th(end)-sin_th(1)
berr = (sin_therr(1)^2+sin_therr(end)^2)^0.5
droughhar = lambda/(b/6)
droughharerr = droughhar*(berr/b)

figure
errorbar(-2.5:2.5,sin_th,sin_therr,sin_therr,zeros(1,6),zeros(1,6))
xlabel("Bylgju toppa númer [n]")
ylabel('sin \theta')

%% tilraun 4 útreikningar

tilraun4err = tilraun4.*0.05;
degMarkererr = 5*ones(1, length(degMarker));

figure
errorbar(degMarker, tilraun4, tilraun4err,tilraun4err, degMarkererr,degMarkererr); hold on;
plot(0:180,max(tilraun4)*cos(pi/180.*((0:180)+40)).^2); hold off;
xlabel("Skautunar hliðrun [Gráður]")
ylabel("Styrkur [Amper]")
axis([-6 186 0 1.8e-4])
