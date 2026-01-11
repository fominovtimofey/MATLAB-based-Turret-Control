figure
t = 1:numel(yaw_rad_true);

hold on

plot(t, yaw_rad_true,  'LineWidth', 1.6);
plot(t, pitch_rad_true,'LineWidth', 1.6);
plot(t, yaw_rad_target,  'LineWidth', 1.6);
plot(t, pitch_rad_target,'LineWidth', 1.6);

title('Turret Pitch and Yaw')
xlabel('Step Index')
ylabel('Angle [rad]')
legend('Yaw True','Pitch True', 'Yaw Target', 'Pitch Target', 'Location','best')
grid on
hold off

figure

hold on

plot3(0,0,0,'o', 'MarkerSize',12, 'MarkerFaceColor','r', 'MarkerEdgeColor','k')
plot3(x,y,z, 'LineWidth', 1.6)
plot3(target_x, target_y, target_z, 'LineWidth', 1.6)

view(3)

xlabel('X Position')
ylabel('Y Position')
zlabel('Z Position')
title('3D Trajectory and Target')
legend('Turret Location', 'Target Path', 'Target Trajectory Path', 'Location', 'best')
ylim([-1000 1000])

grid on
hold off

figure
hold on
plot(a_x,  'LineWidth', 1.6);
plot(a_y,'LineWidth', 1.6);
plot(a_z,  'LineWidth', 1.6);

title('Acceleration of Target')
xlabel('Step Index')
ylabel('Acceleration (m/step^2)')
legend('a_x', 'a_y', 'a_z')

grid on
hold off