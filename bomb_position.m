function [dropTime, bombPosX] = bomb_position()
    %% Calculate
    [JET_H, JET_VEL, G, ~, ~, ~] = constants();

    bombVel = JET_VEL;
    bombPosYStart = JET_H;

    % calculate position and time of bomb drop
    dropTime = sqrt(2 * bombPosYStart / G);
    bombPosX = bombVel * dropTime;
end
