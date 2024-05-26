function [plane_xs, plane_ys, ts, xs, ys, rs] = simulation()
    [JET_H, JET_VEL, G, BOMB_VEL, MIN_RADIUS, dt] = constants();
    [drop_time, bombPosY] = bomb_position();

    hirosima_x = bombPosY;
    v = JET_VEL; 
    t = drop_time;  

    ts = 0:0.2:300;
    [xs, ys] = bomb_location(ts);

    r = 4700

    phi = atan(r / hirosima_x);
    tangent_x = r + r * cos(2 * phi);
    tangent_y = r * sin(2 * phi);
    time_to_tangent = r * (pi - 2 * phi) / v;
    fprintf('  Time to tangent: %.4f\n', time_to_tangent);

    plane_xs = r - r * cos(v * ts / r);
    plane_ys = r * sin(v * ts / r);

    plane_xs(ts >= time_to_tangent) = tangent_x + sin(pi - 2 * phi) * v 
                        * (ts(ts > time_to_tangent) - time_to_tangent);
    plane_ys(ts >= time_to_tangent) = tangent_y + cos(pi - 2 * phi) * v 
                        * (ts(ts > time_to_tangent) - time_to_tangent);

    rs = shockwave_radius(ts - drop_time);

    vreme_sudara = 0;
    for i = 1:length(ts)
        if rs(i) > sqrt( (bombPosY - plane_ys(i))^2 + (0 + plane_xs(i))^2 + JET_H^2)
            vreme_sudara = ts(i);
            break
        end
    end

    fprintf('  Vreme sudara: %.4f\n', vreme_sudara)
end
