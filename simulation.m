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
axis([0 20000 -10000 10000 0 20000]);
[xs, ys] = bomb_location(ts);

% Find optimal radius
distance = @(r, t) sqrt((jetX + r - r * cos(v * t / r) - bombX)^2 + (jetY + r * sin(v * t / r) - bombY)^2);
optimal_r = fminbnd(@(r) -distance(r, t), MIN_RADIUS, 10000);


phi = atan(optimal_r / bombY);
tangentX = optimal_r + optimal_r * cos(2 * phi);
tangentY = optimal_r * sin(2 * phi);
timeToTangent = optimal_r * (pi - 2 * phi) / v;

plane_xs = optimal_r - optimal_r * cos(v * ts / optimal_r);
plane_ys = optimal_r * sin(v * ts / optimal_r);

plane_xs(ts >= timeToTangent) = tangentX + sin(pi - 2 * phi) * v * (ts(ts > timeToTangent) - timeToTangent);
plane_ys(ts >= timeToTangent) = tangentY + cos(pi - 2 * phi) *v * (ts(ts > timeToTangent) - timeToTangent);

fprintf('  The optimal r is: %.4f\n', optimal_r);
fprintf('Time toTangent: %.4f\n', timeToTangent);
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

    if rs(i) > sqrt( (x0 - plane_ys(i))^2 + (0 + plane_xs(i))^2 + (y0 - JET_H)^2)
        plane_xs(i)
        plane_ys(i)
        break
    end
    pause(0.001);
end

axis equal