clear; close all; clc;

%% Constants
g = 9.81;
rho_air = 1.293;

%% Projectile Properties
projectile_velocity = 800;
CA = 0.0127;
Cd = 0.2;

%% Target Path

run('target_path.m')

P = [x(:) y(:) z(:)];
dP = diff(P);
segment_lengths = vecnorm(dP,2,2);

target_velocity = 250;

%% Angles and Predicted Target Position
pitch_rad_true   = zeros(1,N);
yaw_rad_true     = zeros(1,N);
pitch_rad_target = zeros(1,N);
yaw_rad_target   = zeros(1,N);

target_x = zeros(1,N);
target_y = zeros(1,N);
target_z = zeros(1,N);

diff_x = zeros(1,N-1);
diff_y = zeros(1,N-1);
diff_z = zeros(1,N-1);

a_x = zeros(1,N-2);
a_y = zeros(1,N-2);
a_z = zeros(1,N-2);

for k = 1:N

    if k < 1.5
        diff_x(k) = 0;
        diff_y(k) = 0;
        diff_z(k) = 0;

        if k < 3
            a_x(k) = 0;
            a_y(k) = 0;
            a_z(k) = 0;
        else
            a_x(k) = x(k) - 2*x(k-1) + x(k-2);
            a_y(k) = y(k) - 2*y(k-1) + y(k-2);
            a_z(k) = z(k) - 2*z(k-1) + z(k-2);
        end


    else
        diff_x(k) = x(k) - x(k-1);
        diff_y(k) = y(k) - y(k-1);
        diff_z(k) = z(k) - z(k-1);

        a_x(k) = diff_x(k) / diff_x(k-1);
        a_y(k) = diff_y(k) / diff_y(k-1);
        a_z(k) = diff_z(k) / diff_z(k-1);
    end

    target_x(k) = x(k) + sign(diff_x(k)) * abs(a_x(k)) * 100; 
    target_y(k) = y(k) + sign(diff_y(k)) * abs(a_y(k)) * 100; 
    target_z(k) = z(k) + sign(diff_z(k)) * abs(a_z(k)) * 100;

    if target_z(k) < 0
        target_z(k) = 0;
    else
        target_z(k) = target_z(k);
    end

    pitch_rad_true(k) = atan2(z(k), sqrt(x(k)^2 + y(k)^2));
    yaw_rad_true(k)   = atan2(y(k), x(k));
    pitch_rad_target(k) = atan2(target_z(k), sqrt(target_x(k)^2 + target_y(k)^2));
    yaw_rad_target(k)   = atan2(target_y(k), target_z(k));

end

%% Plots
% run("animation.m")
run("figures.m")