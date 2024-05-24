[JET_H, JET_VEL, G, BOMB_VEL, MIN_RADIUS, dt] = constants();
[dropTime, bombPosY] = bomb_position();

jetX = 0;
jetY = 0; 
bombX = 0;
bombY = bombPosY;
v = JET_VEL; 
t = dropTime;  
r = MIN_RADIUS;

ts = 0:0.1:300;
figure;
hold on;
grid on;
axis([0 10000 -5000 5000 0 10000]);
[xs, ys] = bomb_location(ts);

% Find optimal radius
distance = @(r, t) sqrt((jetX + r - r * cos(v * t / r) - bombX)^2 + (jetY + r * sin(v * t / r) - bombY)^2);
optimal_r = fminbnd(@(r) -distance(r, t), MIN_RADIUS, 10000);

plane_xs = optimal_r - optimal_r * cos(v * ts / optimal_r);
plane_ys = optimal_r * sin(v * ts / optimal_r);

fprintf('  The optimal r is: %.4f\n', optimal_r);


rs=shockwave_radius(ts - dropTime);

x0=bombPosY;
y0=0;
theta = linspace(0,2*pi,100);
[X,Y,Z] = sphere;
bomb_path = plot3(0,0,0,'.');
plane_path = plot3(0,0,0,'.');
for i = 1:length(ts)
    if ts(i) < dropTime
        set(bomb_path,'XData',xs(1:i),'YData',zeros(size(xs(1:i))), 'ZData', ys(1:i));
    end
    r = rs(i);
    if r > 0
        X2 = X * r;
        Y2 = Y * r;
        Z2 = Z * r;

        surf(X2+x0,Y2,Z2+y0)
    end
    set(plane_path,'XData',plane_ys(1:i),'YData',-plane_xs(1:i)  ,'ZData',JET_H * ones(size(plane_xs(1:i))));
    pause(0.01);
end

axis equal