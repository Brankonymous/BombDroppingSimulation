function [plane_xs, plane_ys, ts, xs, ys, rs] = simulation()
    [JET_H, JET_VEL, G, EXPLOSION_VEL, MIN_RADIUS, dt] = constants();
    [drop_time, detonation_y] = bomb_position();

    v = JET_VEL; 
    h = JET_H;
    r = MIN_RADIUS;

    ts = 0:dt:300;
    [xs, ys] = bomb_location(ts);

    phi = atan(r / detonation_y);
    tangent_x = r + r * cos(2 * phi);
    tangent_y = r * sin(2 * phi);
    time_to_tangent = r * (pi - 2 * phi) / v;
    fprintf('  Time to tangent: %.4f\n', time_to_tangent);

    plane_xs = r - r * cos(v * ts / r);
    plane_ys = r * sin(v * ts / r);

    plane_xs(ts >= time_to_tangent) = tangent_x + sin(pi - 2 * phi) * v * (ts(ts > time_to_tangent) - time_to_tangent);
    plane_ys(ts >= time_to_tangent) = tangent_y + cos(pi - 2 * phi) * v * (ts(ts > time_to_tangent) - time_to_tangent);

    rs = shockwave_radius(ts - drop_time);

    time_of_impact = 0;
    for i = 1:length(ts)
        if rs(i) > sqrt( (detonation_y - plane_ys(i))^2 + (0 + plane_xs(i))^2 + h^2)
            time_of_impact = ts(i);
            break
        end
    end

    fprintf('  Vreme sudara: %.4f\n', time_of_impact);
end
