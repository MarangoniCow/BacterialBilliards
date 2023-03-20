% EXAMPLES
% Common args
P = [2*rand; 2*rand] - 1;
P = P./norm(P);
X = [rand; rand];


% CIRCLE OF RADIUS 5 EXAMPLE
r = 5;
t = linspace(0, 2*pi, 1000);
x = r.*cos(t);
y = r.*sin(t);
boundary = [x; y];
[x, y] = fetchIntersectPoints(boundary, 'initialPoint', X, 'initialTrajectory', P);
renderBacteriaPaths(boundary, x, y);

% TRIANGLE EXAMPLE
x = [linspace(-5, 0), linspace(0, 5), linspace(5, -5, 200)];
y = [linspace(0, 5), linspace(5, 0), zeros(1, 200)];
boundary = [x; y];
[x, y] = fetchIntersectPoints(boundary, 'initialPoint', X, 'initialTrajectory', P);
renderBacteriaPaths(boundary, x, y);

% OTHER EXAMPLE
r = 5*ones(1, 1000);
v = linspace(0, 24*pi, 1000);
x = r.*cos(t);
y = (r + cos(v)).*sin(t);
boundary = [x; y];
[x, y] = fetchIntersectPoints(boundary, 'initialPoint', X, 'initialTrajectory', P);
renderBacteriaPaths(boundary, x, y);


