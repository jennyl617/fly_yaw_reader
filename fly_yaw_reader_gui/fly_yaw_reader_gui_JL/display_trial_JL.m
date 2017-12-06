function [] = display_trial_JL( task, trial_time, trial_data, viz_figs, exp_dir )

colors = {'black','red', 'green', 'blue'};
cur_color = '';

if( (strcmp(task, 'Control') == 1 ) )
    cur_color = colors{1};
elseif( strcmp(task, 'ClosedLoop') == 1 )
    cur_color = colors{2};
elseif( strcmp(task, 'OpenLoopLeft') == 1 )
     cur_color = colors{3};
elseif( strcmp(task, 'OpenLoopRight') == 1 )
     cur_color = colors{4};
else
    disp(['ERROR: Task: ' task ' is not recognized.']);
end

settings = sensor_settings_JL;

%% obtaining zero for the ball output
ZeroBall = false;
if ZeroBall
    display(mean(trial_data(:,1:4))); % use this value in sensor_settings.m
end
%%
[ t, vel_forward, vel_side, vel_yaw ] = get_velocity_JL(trial_time, trial_data, exp_dir, 1); 
%[vel_forward,vel_side,vel_yaw] = convert_velocity_JL(v_forward, v_side, v_yaw); % convert based on calibration data

%% Display trial velocities
figure(viz_figs.velocity_tc_fig);

% Plot forward
subplot(3,1,1);
hold on;
plot( t, vel_forward, 'color', cur_color );
ylabel('v_{forward} (mm/s)');
xlim([0 trial_time(end)]);
title('All the trials')

subplot(3,1,2);
hold on;
plot( t, vel_side, 'color', cur_color );
ylabel('v_{side} (mm/s)');
xlim([0 trial_time(end)]);

subplot(3,1,3);
hold on;
plot( t, vel_yaw, 'color', cur_color );
ylabel('v_{yaw} (deg/s)');
xlabel('Time (s)');
xlim([0 trial_time(end)]);


%% display single trial 
figure(viz_figs.velocity_tc_single_fig);
clf;

% Plot forward
subplot(3,1,1);
hold on;
plot( t, vel_forward, 'color', cur_color );
ylabel('v_{forward} (mm/s)');
xlim([0 trial_time(end)]);
title(task)

subplot(3,1,2);
hold on;
plot( t, vel_side, 'color', cur_color );
ylabel('v_{side} (mm/s)');
xlim([0 trial_time(end)]);

subplot(3,1,3);
hold on;
plot( t, vel_yaw, 'color', cur_color );
ylabel('v_{yaw} (deg/s)');
xlabel('Time (s)');
xlim([0 trial_time(end)]);


%% Display trial raw trajectory
figure(viz_figs.run_traj_fig);

dt = 1.0/settings.sensorPollFreq;
%[disp_x, disp_y, theta] = calculate_fly_position_with_yaw(vel_forward, vel_side, vel_yaw, dt, 0, 0, 0);
[disp_x, disp_y] = calculate_fly_position_no_yaw(vel_forward, vel_side, dt, 0, 0);
hold on;
plot(disp_x, disp_y, 'color', cur_color);
xlabel('X displacement (mm)');
ylabel('Y displacement (mm)');

%h = legend('Both Odor', 'Left Odor', 'Right Odor');
%legendlinecolors(h, {'blue', 'red', 'green'});
%h = legend('Left Odor', 'Right Odor');
%legendlinecolors(h, {'red', 'green'});

end

