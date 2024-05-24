function [tanX, tanY, phi] = findTangents(y0, R, y1)
    % calculate phi
    phi = atan2(R, y1 - y0);

    tanX = R + R * cos(2 * phi);
    tanY = R * sin(2 * phi);
end