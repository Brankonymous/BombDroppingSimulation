[dropTime, bombPosY] = bomb_position();
[JET_H, JET_VEL, G, BOMB_VEL, MIN_RADIUS, dt] = constants();
[plane_xs, plane_ys, ts, xs, ys, rs] = simulation();

% video = VideoWriter('simulation.mp4', 'MPEG-4');
% open(video);

figure;
hold on;
grid on;
axis([0 20000 -10000 10000 0 20000]);

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
        finalJetPositionX = plane_xs(i);
        finalJetPositionY = plane_ys(i);
        finalJetPositionZ = JET_H;
        plot3(finalJetPositionY, -finalJetPositionX, finalJetPositionZ, 'o', 'Color', 'black', 'MarkerSize', 10);
        fprintf('  Final position: (%.2f, %.2f, %.2f)\n', finalJetPositionX, finalJetPositionY, finalJetPositionZ);
        break
    end

    % frame = getframe(gcf);
    % writeVideo(video, frame);
    pause(0.001);
end

% close(video);
axis equal


