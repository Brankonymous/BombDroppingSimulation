function [X, Y] = bomb_location(t)
    [JET_H, JET_VEL, G, ~, ~, ~] = constants();

    X = JET_VEL * t;
    Y = JET_H - G * t.^2 / 2;

end