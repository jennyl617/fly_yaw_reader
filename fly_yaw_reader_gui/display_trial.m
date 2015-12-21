function [] = display_trial( task, trial_time, trial_data, viz_figs )

colors = {'red', 'green', 'blue', 'black'};
cur_color = '';

if( strcmp(task, 'LeftOdor') == 1 )
    cur_color = colors{1};
elseif( strcmp(task, 'RightOdor') == 1 )
    cur_color = colors{2};
elseif( strcmp(task, 'BothOdor') == 1 )
    cur_color = colors{3};
elseif( strcmp(task, 'NaturalOdor') == 1 )
    cur_color = colors{4};
else
    disp(['ERROR: Task: ' task ' is not recognized.']);
end

settings = sensor_settings;

sensor1_x = trial_data(:,1);
sensor1_y = trial_data(:,2);
sensor2_x = trial_data(:,3);
sensor2_y = trial_data(:,4);

[ t, vel1_x ] = get_velocity_from_raw_input( sensor1_x, trial_time, settings.zero_mean_voltage_per_channel(1), settings.zero_mean_two_std_per_channel(1) );
[ t, vel1_y ] = get_velocity_from_raw_input( sensor1_y, trial_time, settings.zero_mean_voltage_per_channel(2), settings.zero_mean_two_std_per_channel(2) ); 
[ t, vel2_x ] = get_velocity_from_raw_input( sensor2_x, trial_time, settings.zero_mean_voltage_per_channel(3), settings.zero_mean_two_std_per_channel(3) );
[ t, vel2_y ] = get_velocity_from_raw_input( sensor2_y, trial_time, settings.zero_mean_voltage_per_channel(4), settings.zero_mean_two_std_per_channel(4) );

% Below is from Seelig et al. Nature Methods 2010, methods section
vel_forward = -1*((vel1_y + vel2_y)*cos(deg2rad(45)));
vel_side    = -1*((vel1_y - vel2_y)*sin(deg2rad(45)));
vel_yaw     = -1*((vel1_x + vel2_x) ./ 2.0);

% Display trial velocities
figure(viz_figs.velocity_tc_fig);

% Plot forward
subplot(3,1,1);
hold on;
plot( t, vel_forward, 'color', cur_color );
ylabel('au/s');
xlabel('Time (s)');
xlim([0 trial_time(end)]);
title('Forward velocity');

subplot(3,1,2);
hold on;
plot( t, vel_side, 'color', cur_color );
ylabel('au/s');
xlabel('Time (s)');
xlim([0 trial_time(end)]);
title('Side velocity');

subplot(3,1,3);
hold on;
plot( t, vel_yaw, 'color', cur_color );
ylabel('au/s');
xlabel('Time (s)');
xlim([0 trial_time(end)]);
title('Yaw velocity');

% Display trial raw trajectory
figure(viz_figs.run_traj_fig);

dt = 1.0/settings.sensorPollFreq;
%[disp_x, disp_y, theta] = calculate_fly_position_with_yaw(vel_forward, vel_side, vel_yaw, dt, 0, 0, 0);
[disp_x, disp_y] = calculate_fly_position_no_yaw(vel_forward, vel_side, dt, 0, 0);
hold on;
plot(disp_x, disp_y, 'color', cur_color);
xlabel('X displacement (au)');
ylabel('Y displacement (au)');
h = legend('Both Odor', 'Left Odor', 'Right Odor');
legendlinecolors(h, {'blue', 'red', 'green'});

end

