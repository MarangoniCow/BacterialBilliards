% Angle
t = linspace(0,2*pi);

% r is variable radius
r1 = 1;  x1 = r1.*cos(t); y1 = r1.*sin(t);
r2 = 2;  x2 = r2.*cos(t); y2 = r2.*sin(t);




P = InterX([x1;y1],[B1x;B1y]);
plot(x1,y1,B1x, B1y,P(1,:),P(2,:),'ro')