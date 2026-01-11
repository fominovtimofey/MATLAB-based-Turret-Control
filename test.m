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
cumulative_distance = [0; cumsum(segment_lengths)];
target_path_distance = max(cumulative_distance);


%% Angles and Predicted Target Position
pitch_rad_true   = zeros(1,length(x));
yaw_rad_true     = zeros(1,length(x));
pitch_rad_target = zeros(1,length(x));
yaw_rad_target   = zeros(1,length(x));

target_x = zeros(1,length(x));
target_y = zeros(1,length(x));
target_z = zeros(1,length(x));

for k = 1:length(x)

    pitch_rad_true(k) = atan2(z(k), sqrt(x(k)^2 + y(k)^2));
    yaw_rad_true(k)   = atan2(y(k), z(k));

    true_distance = sqrt(x(k)^2 + y(k)^2 + z(k)^2);
    true_time_required = true_distance / target_velocity;

    if k == 1
        dvec = P(2,:) - P(1,:);
    else
        dvec = P(k,:) - P(k-1,:);
    end

    direction = dvec / norm(dvec);
    future_offset = direction * target_velocity * true_time_required;

    target_x(k) = x(k) + future_offset(1);
    target_y(k) = y(k) + future_offset(2);
    target_z(k) = z(k) + future_offset(3);

    if target_z(k) < 0
        target_z(k) = 0;
    else
        target_z(k) = target_z(k);
    end

    pitch_rad_target(k) = atan2(target_z(k), sqrt(target_x(k)^2 + target_y(k)^2));

    % if pitch_rad_target(k) < 0
    %     pitch_rad_target(k) = 0;
    % else
    %     pitch_rad_target(k) = pitch_rad_target(k);
    % end

    yaw_rad_target(k)   = atan2(target_y(k), target_z(k));

end

%% Plots
run("animation.m")
run("figures.m")