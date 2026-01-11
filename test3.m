clear; close all; clc;

% Parameters
run("target_path.m")
scale = 10000;

% Preallocate velocity and acceleration
v_x = zeros(1, N); v_y = zeros(1, N); v_z = zeros(1, N);
a_x = zeros(1, N); a_y = zeros(1, N); a_z = zeros(1, N);

pitch_rad_true   = zeros(1,N);
yaw_rad_true     = zeros(1,N);
pitch_rad_target = zeros(1,N);
yaw_rad_target   = zeros(1,N);

% Central difference velocity
for k = 2:N-1
    v_x(k) = (x(k+1) - x(k-1)) / 2;
    v_y(k) = (y(k+1) - y(k-1)) / 2;
    v_z(k) = (z(k+1) - z(k-1)) / 2;
end

% Second difference acceleration
for k = 2:N-1
    a_x(k) = x(k+1) - 2*x(k) + x(k-1);
    a_y(k) = y(k+1) - 2*y(k) + y(k-1);
    a_z(k) = z(k+1) - 2*z(k) + z(k-1);
end

% Target position logic: add or subtract acceleration
target_x = zeros(1, N);
target_y = zeros(1, N);
target_z = zeros(1, N);

for k = 1:N
    target_x(k) = x(k) + a_x(k) * scale; 
    target_y(k) = y(k) + a_y(k) * scale; 
    target_z(k) = z(k) + a_z(k) * scale;
    pitch_rad_true(k) = atan2(z(k), sqrt(x(k)^2 + y(k)^2));
    yaw_rad_true(k)   = atan2(y(k), x(k));
    pitch_rad_target(k) = atan2(target_z(k), sqrt(target_x(k)^2 + target_y(k)^2));
    yaw_rad_target(k)   = atan2(target_y(k), target_z(k));
end


% run("animation.m")
run("figures.m")