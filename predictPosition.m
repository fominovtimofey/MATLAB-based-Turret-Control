function pT = predictPosition(p0, yaw, pitch, yawRate, pitchRate, V, T)

x0 = p0(1);
y0 = p0(2);
z0 = p0(3);

psi0 = yaw;
th0  = pitch;

r = yawRate;
q = pitchRate;

psiT = psi0 + r*T;
thT  = th0  + q*T;

%% Z integral
% ż = V*sin(theta)
if abs(q) < 1e-9
    zT = z0 + V*T*sin(th0);
else
    zT = z0 + (V/q)*(cos(th0) - cos(thT));
end

%% X,Y integrals
% ẋ = V*cos(theta)*cos(psi)
% ẏ = V*cos(theta)*sin(psi)

A = th0;   % theta0
B = q;     % theta rate
C = psi0;  % psi0
D = r;     % psi rate

% Using product-to-sum identities:
% cos(theta)cos(psi) = 0.5*(cos(theta-psi) + cos(theta+psi))
% cos(theta)sin(psi) = 0.5*(sin(psi+theta) + sin(psi-theta))

Ix = 0;
Iy = 0;

% ---- (q - r) term ----
if abs(B - D) < 1e-9
    % Limit as q -> r
    Ix = Ix + 0.5 * ( ...
        T*cos(A - C) );
    Iy = Iy + 0.5 * ( ...
        T*sin(C - A) );
else
    Ix = Ix + 0.5 * ( ...
        ( sin((A - C) + (B - D)*T) - sin(A - C) ) / (B - D) );
    Iy = Iy + 0.5 * ( ...
        ( -cos((A - C) + (B - D)*T) + cos(A - C) ) / (B - D) );
end

% ---- (q + r) term ----
if abs(B + D) < 1e-9
    % Limit as q -> -r
    Ix = Ix + 0.5 * ( ...
        T*cos(A + C) );
    Iy = Iy + 0.5 * ( ...
        T*sin(A + C) );
else
    Ix = Ix + 0.5 * ( ...
        ( sin((A + C) + (B + D)*T) - sin(A + C) ) / (B + D) );
    Iy = Iy + 0.5 * ( ...
        ( -cos((A + C) + (B + D)*T) + cos(A + C) ) / (B + D) );
end

xT = x0 + V * Ix;
yT = y0 + V * Iy;

pT = [xT, yT, zT];

end
