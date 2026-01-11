%% Environmental Constants
clear; close all; clc

g = 9.81; % m/s^2

%% Projectile Properties
mass = 31; % kg
v0 = 800;  % m/s
pitch = 70;
yaw   = 15;

%% Initial velocity components
vx = v0 * cos(pitch) * cos(yaw);
vy = v0 * cos(pitch) * sin(yaw);
vz = v0 * sin(pitch);

%% Simulation setup
dt = 0.01;
t  = 0:dt:10;
N  = numel(t);

x = zeros(1,N);
y = zeros(1,N);
z = zeros(1,N);

%% Time-stepped simulation
for i = 2:N
    % Update positions
    x(i) = x(i-1) + vx * dt;
    y(i) = y(i-1) + vy * dt;
    z(i) = z(i-1) + vz * dt;

    % Update vertical velocity (gravity)
    vz = vz - g * dt;

    % Stop when projectile hits the ground
    if z(i) < 0
        x = x(1:i);
        y = y(1:i);
        z = z(1:i);
        break
    end
end

%% Plot
figure
plot3(x, y, z)
xlabel('X Position (m)')
ylabel('Y Position (m)')
zlabel('Z Position (m)')
title('Projectile Motion in 3D')
grid on
