function [R] = shockwave_radius(t)
    [~, ~, ~, BOMB_VEL, ~, ~] = constants();

    R = BOMB_VEL * t;
end