
[JET_H, JET_VEL, G, BOMB_VEL, MIN_RADIUS, dt] = constants();
[dropTime, bombPosY] = bomb_position();

jetX = 0;
jetY = 0; 
bombX = 0;
bombY = bombPosY;
v = BOMB_VEL; 
t = dropTime;  

r = MIN_RADIUS;
plotT = linspace(0, dropTime, 1000);
x = jetX + r - r * cos(v * plotT / r);
y = jetY + r * sin(v * plotT / r);
plot(0, 0, 'o', 'Color', 'green');
hold on;
plot(bombX, bombY, 'o', 'Color', 'red');
hold on;
plot(x, y, 'Color', 'blue');
hold on;

[tanX, tanY, phi] = findTangents(jetY, MIN_RADIUS, bombY);
plot([tanX, bombX], [tanY, bombY], 'Color', 'black');
hold on;

timeToTangent = MIN_RADIUS / phi / v;
fprintf('Time from O to T: %.2f seconds\n', timeToTangent);


% FIND OPTIMAL R
% distance = @(r, t) sqrt((jetX + r - r * cos(v * t / r) - bombX)^2 + (jetY + r * sin(v * t / r) - bombY)^2);
% optimal_r = fminbnd(@(r) -distance(r, dropTime), MIN_RADIUS, 10000);
% fprintf('The optimal r is: %.4f\n', optimal_r);
% jetX = jetX + optimal_r - optimal_r * cos(v * t / optimal_r);
% jetY = jetY + optimal_r * sin(v * t / optimal_r);
% plot(jetX, jetY, 'o', 'Color', 'green');
% FIND OPTIMAL R
% optimal_r = fminbnd(@(r) -distance(r, dt), MIN_RADIUS, 10000);
% fprintf('The optimal r is: %.4f\n', optimal_r);
