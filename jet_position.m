
[JET_H, JET_VEL, G, BOMB_VEL, MIN_RADIUS, dt] = constants();
[dropTime, bombPosY] = bomb_position();

jetX = 0;
jetY = 0; 
bombX = 0;
bombY = bombPosY;
v = JET_VEL; 
t = dropTime;  
r = MIN_RADIUS;

fprintf('  Drop time: %.2f seconds\n', dropTime);

plot(0, 0, 'o', 'Color', 'green');
text(0 + 80, 0 + 80, 'O', 'FontSize', 20)
hold on;
plot(bombX, bombY, 'o', 'Color', 'red');
text(bombX + 80, bombY + 80, 'H', 'FontSize', 20)
hold on;

% Find optimal radius
distance = @(r, t) sqrt((jetX + r - r * cos(v * t / r) - bombX)^2 + (jetY + r * sin(v * t / r) - bombY)^2);
optimal_r = fminbnd(@(r) -distance(r, t), MIN_RADIUS, 10000);
jetX = jetX + optimal_r - optimal_r * cos(v * t / optimal_r);
jetY = jetY + optimal_r * sin(v * t / optimal_r);

fprintf('  The optimal r is: %.4f\n', optimal_r);

plot(jetX, jetY, 'o', 'Color', 'green');
text(jetX + 80, jetY + 80, 'D', 'FontSize', 20);
hold on;

% Caluclate phi, tangent point, time to tangent 
phi = atan(optimal_r / bombY);
tangentX = optimal_r + optimal_r * cos(2 * phi);
tangentY = optimal_r * sin(2 * phi);
timeToTangent = optimal_r * (pi - 2 * phi) / v;

fprintf('  Phi: %.4f degrees\n', phi*180/pi);
fprintf('  Time to tangent: %.2f seconds\n', timeToTangent);

plot([tangentX, bombX], [tangentY, bombY], 'Color', 'black');
hold on;
plot(tangentX, tangentY, 'o', 'Color', 'green');
text(tangentX + 80, tangentY + 80, 'T', 'FontSize', 20);
hold on;

plotT = linspace(0, t, 1000);
x = optimal_r - optimal_r * cos(v * plotT / optimal_r);
y = optimal_r * sin(v * plotT / optimal_r);
plot(x, y, 'Color', 'blue');
hold on;

fprintf('  Time from O to T: %.2f seconds\n', timeToTangent);
plotT = linspace(0, timeToTangent - t, 1000);
x = optimal_r - optimal_r * cos(v * (t + plotT) / optimal_r);
y = optimal_r * sin(v * (t + plotT) / optimal_r);
plot(x, y, 'Color', 'red');
hold on;

fprintf('  Time from D to T: %.2f seconds\n', timeToTangent - t);
