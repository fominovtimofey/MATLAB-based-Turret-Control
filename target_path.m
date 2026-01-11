
N = 1000;                      % Define desired length
x = linspace(0, 1000, N);      % Preallocate x with values
y = zeros(1, N);               % Preallocate y
z = zeros(1, N);               % Preallocate z

y = 250 * sin(0.005 * x);
z = 250 * cos(0.005 * x) + 1000;

% Preallocate
v_x = zeros(1,N); v_y = zeros(1,N); v_z = zeros(1,N);
a_x = zeros(1,N); a_y = zeros(1,N); a_z = zeros(1,N);

% Velocity: central difference
for k = 2:N-1
    v_x(k) = (x(k+1) - x(k-1)) / 2;
    v_y(k) = (y(k+1) - y(k-1)) / 2;
    v_z(k) = (z(k+1) - z(k-1)) / 2;
end

% Acceleration: second central difference
for k = 2:N-1
    a_x(k) = x(k+1) - 2*x(k) + x(k-1);
    a_y(k) = y(k+1) - 2*y(k) + y(k-1);
    a_z(k) = z(k+1) - 2*z(k) + z(k-1);
end
