lambda = 700e-9;

N = 2;

b = .15e-3;
a =  1e-3;

range = linspace(-16e-3, 16e-3, 1e4);

bet = pi*b/lambda.*sin(range);
al = pi*a/lambda.*sin(range);

y = (sin(bet)./bet).^2.*(sin(N*al)./sin(al)).^2;

plot(range, y)