
[JET_H, JET_VEL, G, BOMB_VEL, MIN_RADIUS, dt] = constants();
[dropTime, bombPosY] = bomb_position();

jetX = 0;
jetY = 0; 
bombX = 0;
bombY = bombPosY;
v = JET_VEL; 
t = dropTime;  
r = MIN_RADIUS;

plot(0, 0, 'o', 'Color', 'green');
hold on;
plot(bombX, bombY, 'o', 'Color', 'red');
hold on;

% FIND OPTIMAL R
distance = @(r, t) sqrt((jetX + r - r * cos(v * t / r) - bombX)^2 + (jetY + r * sin(v * t / r) - bombY)^2);
optimal_r = fminbnd(@(r) -distance(r, t), MIN_RADIUS, 10000);
fprintf('The optimal r is: %.4f\n', optimal_r);
jetX = jetX + optimal_r - optimal_r * cos(v * t / optimal_r);
jetY = jetY + optimal_r * sin(v * t / optimal_r);
plot(jetX, jetY, 'o', 'Color', 'green');
hold on;
% FIND OPTIMAL R

[tanX, tanY, phi] = findTangents(0, optimal_r, bombY);
plot([tanX, bombX], [tanY, bombY], 'Color', 'black');
hold on;
timeToTangent = optimal_r / (pi-2*phi) / v;

plotT = linspace(0, dropTime, 1000);
x = optimal_r - optimal_r * cos(v * plotT / optimal_r);
y = optimal_r * sin(v * plotT / optimal_r);
plot(x, y, 'Color', 'blue');
hold on;

fprintf('Drop time: %.2f seconds\n', t);
fprintf('Time from O to T: %.2f seconds\n', timeToTangent);
plotT = linspace(0, timeToTangent, 1000);
x = optimal_r - optimal_r * cos(v * (t + plotT) / optimal_r);
y = optimal_r * sin(v * (t + plotT) / optimal_r);
plot(x, y, 'Color', 'red');
hold on;

fprintf('Time from T to B: %.2f seconds\n', t - timeToTangent);