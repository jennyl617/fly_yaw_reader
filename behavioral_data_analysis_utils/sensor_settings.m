function settings = sensor_settings

% Acquisition params
settings.sampRate = 4000;

% Stim parameters
settings.pre_stim = 3.0;
settings.stim = 0.5;
settings.post_stim = 3.0;

% Processing settings
settings.zero_mean_voltage_per_channel = [2.4682, 2.4541, 2.4725, 2.4685];
%settings.zero_mean_two_std_per_channel = [0.0137, 0.0151, 0.0142, 0.0156];
settings.zero_mean_two_std_per_channel = [0.001, 0.001, 0.001, 0.001];
settings.cutoffFreq = 50;
settings.aiType = 'SingleEnded';
settings.sensorPollFreq = 100; 
