clear;
close all;
%experiment_dir = '\\research.files.med.harvard.edu\Neurobio\Wilson Lab\Jenny\FSB\Data\Behavior\20170607\2p\acv';
experiment_dir = 'X:\Jenny\FSB\Data\Behavior\test';
use_calibration = 1;
cd(experiment_dir)
Dir = dir('*sid*');
Sessions = [11];
settings = sensor_settings;
zero_vel_data = load( [experiment_dir '/' settings.zero_params_filename ] );


viz_figs.run_traj_fig = figure();
viz_figs.velocity_tc_fig = figure();
viz_figs.velocity_tc_single_fig = figure();
analysis_figs.panels = figure();
analysis_figs.voltages = figure();

    
for n=1:length(Sessions)
    File = dir(['*sid_',num2str(Sessions(n)),'_tid_0*']);
    File;
    load(File.name);
    display_trial_JL('ClosedLoop', trial_time, trial_bdata, viz_figs, experiment_dir);
    close(viz_figs.velocity_tc_fig);
    close(viz_figs.run_traj_fig);
    [ t, vel_forward, vel_side, vel_yaw ] = get_velocity_JL(trial_time, trial_bdata, experiment_dir, 1); 
    figure(analysis_figs.panels);
    subplot(2, 1, 1);
    hold on;
    [fr, angle] = process_panel(trial_bdata);
    plot(t, angle, 'red');
    dt = 1.0/settings.sensorPollFreq;
    [disp_x, disp_y, yaw] = calculate_fly_position_with_yaw(vel_forward, vel_side, vel_yaw, dt, 0, 0, 0);
    yaw = -1*yaw+angle(1);
%     hold on;
%     plot(t, yaw);
    hold on;
    yaw_mod = yaw - 2*135*floor( (yaw+135)/(2*135) ); 
    plot(t, yaw_mod, 'blue');
    ylabel('Panel Angle');
    
    subplot(2, 1, 2);
    hold on;
    plot(t, vel_yaw);
    ylabel('Yaw Velocity');
    xlabel('Time (s)');

    
%     yaw = wrapTo180(yaw);
%     arenaAngle = 270;
%     halfArena = arenaAngle./2;
%     indexOver = yaw < -halfArena;
%     yaw = yaw + indexOver.*arenaAngle;
    
    figure(analysis_figs.voltages);
    plot(trial_time, trial_bdata(:,1:4));
end