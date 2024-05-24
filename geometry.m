function [phi] = phiFromR(h, R)
    phi = atan2(R, h);
end

function [Tx, Ty] = tangentPoint(R, phi)
    Tx = R + R * cos(2 * phi);
    Ty = R * sin(2 * phi);
end

function [time] = timeToTangentPoint(R, phi, v)
    time = R / (pi - 2*phi) / v
end
