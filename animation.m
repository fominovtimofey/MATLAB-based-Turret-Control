%% Animation of Target Path + Predicted Path + Trajectory

N = length(x);

% Figure

figure('Color','b'); hold on; grid on;
axis equal;

view(3);
camproj('perspective');
rotate3d on;

xlabel('X'); ylabel('Y'); zlabel('Z');
title('Growing Target Path + Predicted Path + Trajectory');


% Limits
xlim([min(x)-200, max(x)+200]);
ylim([min(y)-200, max(y)+200]);
zlim([0, max(z)+500]);

% Plot handles
hTruePath     = plot3(NaN,NaN,NaN,'b','LineWidth',2);   % true target path
hPredicted    = plot3(NaN,NaN,NaN,'r--','LineWidth',2); % predicted target path
hTrajectory   = plot3(NaN,NaN,NaN,'k','LineWidth',2);   % projectile/turret path

hTruePoint    = plot3(NaN,NaN,NaN,'bo','MarkerFaceColor','b');
hPredPoint    = plot3(NaN,NaN,NaN,'ro','MarkerFaceColor','r');

% Animation
for k = 1:N

    % Update true path
    set(hTruePath, 'XData', x(1:k), ...
                   'YData', y(1:k), ...
                   'ZData', z(1:k));

    % Update predicted path
    set(hPredicted, 'XData', target_x(1:k), ...
                    'YData', target_y(1:k), ...
                    'ZData', target_z(1:k));

    % Update projectile/turret trajectory
    set(hTrajectory, 'XData', [0 target_x(k)], ...
                     'YData', [0 target_y(k)], ...
                     'ZData', [0 target_z(k)]);

    % Update markers
    set(hTruePoint, 'XData', x(k), ...
                    'YData', y(k), ...
                    'ZData', z(k));

    set(hPredPoint, 'XData', target_x(k), ...
                    'YData', target_y(k), ...
                    'ZData', target_z(k));

    drawnow;
    pause(0.0001); % adjust for speed
end
