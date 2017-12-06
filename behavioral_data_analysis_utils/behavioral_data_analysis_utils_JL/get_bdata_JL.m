function [ t, disp_for, disp_side, disp_yaw ] = get_bdata_JL( trial_time, trial_data, experiment_dir, use_calibration )

settings = sensor_settings_JL;
settings.fictrac_x_DAQ_AI = 1;
settings.fictrac_yaw_DAQ_AI = 2;
settings.fictrac_y_DAQ_AI = 3;
settings.panels_DAQ_AI = 4;

% When assigning fictrac directions, x will be side, y will be forward
disp_for = trial_data( :, settings.fictrac_y_DAQ_AI );
disp_yaw = trial_data( :, settings.fictrac_yaw_DAQ_AI );
disp_side = trial_data( :, settings.fictrac_x_DAQ_AI );
panels = trial_data( :, settings.panels_DAQ_AI );

%zero_vel_data = load( [experiment_dir '\' settings.zero_params_filename ] );

[ t, vel1_x ] = get_velocity_from_raw_input( sensor1_x, trial_time, zero_vel_data.zero_mean_per_channel(1), zero_vel_data.zero_std_per_channel(1) );
[ t, vel1_y ] = get_velocity_from_raw_input( sensor1_y, trial_time, zero_vel_data.zero_mean_per_channel(2), zero_vel_data.zero_std_per_channel(2) ); 
[ t, vel2_x ] = get_velocity_from_raw_input( sensor2_x, trial_time, zero_vel_data.zero_mean_per_channel(3), zero_vel_data.zero_std_per_channel(3) );
[ t, vel2_y ] = get_velocity_from_raw_input( sensor2_y, trial_time, zero_vel_data.zero_mean_per_channel(4), zero_vel_data.zero_std_per_channel(4) );

% Below is from Seelig et al. Nature Methods 2010, methods section
vel_fwd = -1*((vel1_y + vel2_y)*cos(deg2rad(45)));
vel_side    = ((vel1_y - vel2_y)*sin(deg2rad(45)));
%vel_yaw     = ((vel1_x + vel2_x) ./ 2.0);
vel_yaw = vel1_x;

% This converts to mm/s for fwd and side. deg/s for yaw;
if use_calibration
    [v_fwd,v_side,v_yaw] = convert_velocity_JL(vel_fwd, vel_side, vel_yaw);
    
    vel_fwd = v_fwd;
    vel_side = v_side;
    vel_yaw = v_yaw;
end
end

