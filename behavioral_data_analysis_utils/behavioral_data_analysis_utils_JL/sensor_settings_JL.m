function settings = sensor_settings_JL

% Acquisition params
settings.sampRate = 4000;

% Processing settings
settings.cutoffFreq = 50;
settings.aiType = 'SingleEnded';
settings.sensorPollFreq = 100; 
settings.zero_params_filename = 'zero_ball_velocity_params.mat';

