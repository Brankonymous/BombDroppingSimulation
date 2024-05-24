[JET_H, JET_VEL, G, BOMB_VEL, MIN_RADIUS, dt] = constants();
[dropTime, bombPosY] = bomb_position();

ts = 0:0.1:dropTime;
figure;
hold on;
grid on;
axis([0 10000 -5000 5000 0 10000]);
[xs, ys] = bomb_location(ts);

rs=shockwave_radius(ts);
x0=bombPosY;
y0=0;
theta = linspace(0,2*pi,100);
h = plot3(0,0,0,'.');
for i = 1:length(ts)
    set(h,'XData',xs(1:i),'YData',zeros(size(xs(1:i))), 'ZData', ys(1:i));
    pause(0.01);
end

[X,Y,Z] = sphere;
for i = 1:length(ts)
    r = rs(i);
    
    X2 = X * r;
    Y2 = Y * r;
    Z2 = Z * r;

    surf(X2+x0,Y2,Z2+y0)
    pause(0.01);
end

axis equal