function [JET_H, JET_VEL, G, BOMB_VEL, MIN_RADIUS, dt] = constants()
    JET_H = 9600;
    JET_VEL = 530 * 1000 / (60 * 60);
    G = 9.81;
    BOMB_VEL = 350;
    MIN_RADIUS = 4700;
    dt = 0.001;
end