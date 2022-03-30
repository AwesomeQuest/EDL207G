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
cntr1pix2mm = @(p) (p-findMidl1(p))*pix2mm

tilraun1 = [62 255 374 490 682];
tilraun1 = cntr1pix2mm(tilraun1);

%% tilraun 2
findMidl2 = @(p) (p(end/2)+p(end/2+1))/2;
cntr2pix2mm = @(p) (p-findMidl2(p))*pix2mm

tilraun2_025 = [266 293 320 346 376 400 427 454];
tilraun2_025 = cntr2pix2mm(tilraun2_025)
%%
tilraun2_05 = [327 342 356 369 382 395];
tilraun2_05 = cntr2pix2mm(tilraun2_05)
%%
tilraun2_075 = [235 279 326 406 448 493];
tilraun2_075 = cntr2pix2mm(tilraun2_075)
%%
tilraun2_1 = [172 221 270 371 421 468];
tilraun2_1 = cntr2pix2mm(tilraun2_1)

%% tilraun 3
tilraun3 = [59 159 259 456 553 648];
tilraun3 = cntr2pix2mm(tilraun3)

%% tilraun 4
degMarker = 0:10:180;
lghtStr = [109.08 78.6 50.15 26.72 10.38 3.16 5.4 17.79 38.97 64.81 95.38 121.48 164.36 164.14 171 169.45 157.37 138.72 112.17]*uA;

%% Tilraun 1 útreikningar

L = 9*cm;
Lerr = 0.1*cm;
d = 1880*nm;

n   = [ -2 	-1 		0 	1 		2 ];
% skrifað
% x_n = [ 9.1	3.55	0	-3.5	-9.3 ]*cm;
% x_nerr = 0.05*cm;

% pixle mælt-
x_n = tilraun1;
x_nerr = 1*mm + 1/3*mm;
sin_th = x_n.*(L^2 +x_n.^2).^-0.5
sin_therr = sin_th.*L^2.*(L^2+x_n.^2).^-1.*(x_nerr./x_n+Lerr/L)

b = [sin_th(1)-sin_th(5) 	sin_th(2)-sin_th(4)]
c = [4 						2 ];
berr = b + [sin_therr(1)+sin_therr(5) sin_therr(2)+sin_therr(4)]
hrough = b./c*d

htrue = polyfit(n, d*sin_th, 1);
htrue = htrue(1)

lambda = d.*sin_th./n