
[JET_H, JET_VEL, G, BOMB_VEL, MIN_RADIUS, dt] = constants();
[dropTime, bombPosY] = bomb_position();

avion_x = 0;
avion_y = 0; 
hirosima_x = 0;
hirosima_y = bombPosY;
v = JET_VEL; 
t = dropTime;  
r = MIN_RADIUS;

fprintf('  Drop time: %.2f seconds\n', dropTime);

plot(0, 0, 'o', 'Color', 'green');
text(0 + 80, 0 + 80, 'O', 'FontSize', 20)
hold on;
plot(hirosima_x, hirosima_y, 'o', 'Color', 'red');
text(hirosima_x + 80, hirosima_y + 80, 'H', 'FontSize', 20)
hold on;

% Find optimal radius
distance = @(r, t) sqrt(
    (r - r * cos(v * t / r) - hirosima_x)^2 + 
    (r * sin(v * t / r) - hirosima_y)^2
);
r_opt = fminbnd(@(r) -distance(r, t), MIN_RADIUS, 1000000);
avion_x = avion_x + r_opt - r_opt * cos(v * t / r_opt);
avion_y = avion_y + r_opt * sin(v * t / r_opt);

fprintf('  The optimal r is: %.4f\n', r_opt);

plot(avion_x, avion_y, 'o', 'Color', 'green');
text(avion_x + 80, avion_y + 80, 'D', 'FontSize', 20);
hold on;

% Caluclate phi, tangent point, time to tangent 
phi = atan(r_opt / hirosima_y);
tangent_x = r_opt + r_opt * cos(2 * phi);
tangent_y = r_opt * sin(2 * phi);
timeToTangent = r_opt * (pi - 2 * phi) / v;

fprintf('  Phi: %.4f degrees\n', phi*180/pi);
fprintf('  Time to tangent: %.2f seconds\n', timeToTangent);

plot([tangent_x, hirosima_x], [tangent_y, hirosima_y], 'Color', 'black');
hold on;
plot(tangent_x, tangent_y, 'o', 'Color', 'green');
text(tangent_x + 80, tangent_y + 80, 'T', 'FontSize', 20);
hold on;

plotT = linspace(0, t, 1000);
x = r_opt - r_opt * cos(v * plotT / r_opt);
y = r_opt * sin(v * plotT / r_opt);
plot(x, y, 'Color', 'blue');
hold on;

fprintf('  Time from O to T: %.2f seconds\n', timeToTangent);
plotT = linspace(0, timeToTangent - t, 1000);
x = r_opt - r_opt * cos(v * (t + plotT) / r_opt);
y = r_opt * sin(v * (t + plotT) / r_opt);
plot(x, y, 'Color', 'red');
hold on;

fprintf('  Time from D to T: %.2f seconds\n', timeToTangent - t);
