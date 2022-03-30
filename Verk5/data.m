%2.1

% v = ;
% epsilon = ;
% mu = ;
% n = ;
% c = ;
% g = ; 
lambda = 525e-9; 
% lambda0 = ;
% Nerr = 10;


% N = 100;
% z = 1.8e-6;
N = [100 94];
Nerr = [10 5];
x = [180e-6 120e-6];
xerr = [10e-6 10e-6];
g = 1/5;
gerr = 1/5*0.01;
z = g.*x
zerr = gerr+xerr;

mesLambda = 2.*z./N
mesLambdaerr = zerr+

% N = z/(lamda/2)


%2.2


L = 50.0 ; %mm
% M = ; 
% f = ;
p = 760e-3;  %Hg
% dM = ;

N = 12;
dcm = 20;

p = [70 50 40 30 20 10]; %cmHg
dp = diff(p);
Dp = 60;
Dp = p(1)-p(end);
m = [0  12 16 21 26 32];
Dm = m(end);
% k = polyfit(p, m, 1);
% k = k(1)
k = Dm/Dp


n=  mesLambda*k/(2*50e-3)*760e-3