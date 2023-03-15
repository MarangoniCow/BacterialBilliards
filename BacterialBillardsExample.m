
r = 5*ones(1, 1000);
v = linspace(0, 24*pi, 1000);
r = 5;
t = linspace(0, 2*pi, 1000);
x = r.*cos(t);
y = (r + 2*sin(5*t)).*sin(t)
% y = r.*sin(t);


x = [linspace(-1, 1), linspace(1, 1), linspace(1, -1), linspace(-1, -1)];
y = [linspace(1, 1), linspace(1, -1), linspace(-1, -1), linspace(-1, 1)];

% x = linspace(-100, 100, 100);
% x = [x, x];
% y = [r*ones(1, 100), -r*ones(1, 100)];
boundary = [x; y];


p = [2*rand; 2*rand] - 1;
% p = [1; 1];
p = p./sqrt(p(1)^2 + p(2)^2);

x = [2*rand; 2*rand] - 1;


[x, y] = fetchIntersectPoints(boundary, 'initialPoint', x, 'initialTrajectory', p);
renderBacteriaPaths(boundary, x, y);