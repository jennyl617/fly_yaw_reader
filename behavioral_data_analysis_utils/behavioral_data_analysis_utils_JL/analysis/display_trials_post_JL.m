clear;
experiment_dir = '\\research.files.med.harvard.edu\Neurobio\Wilson Lab\Jenny\FSB\Data\Behavior\20170525\testing';
%experiment_dir = 'X:\Jenny\FSB\Data\Behavior\ball_calibration_3\yaw'
use_calibration = 1;
cd(experiment_dir)
Dir = dir('*sid*');
Sessions = [0];
settings = sensor_settings;
zero_vel_data = load( [experiment_dir '/' settings.zero_params_filename ] );


viz_figs.run_traj_fig = figure();
viz_figs.velocity_tc_fig = figure();
viz_figs.velocity_tc_single_fig = figure();
    
for n=1:length(Sessions)
    File = dir(['*sid_',num2str(Sessions(n)),'_*']);
    File;
    load(File.name);
    display_trial_JL('Control', trial_time, trial_bdata, viz_figs, experiment_dir);
end