function [ trial_data, trial_time ] = run_trial_JL( trial_idx, task, run_obj, scanimage_client, trial_core_name )

disp(['About to start trial task: ' task]);

% Setup data structures for read / write on the daq board
s = daq.createSession('ni');

% This channel is for external triggering of scanimage 5.1
s.addDigitalChannel('Dev1', 'port0/line0', 'OutputOnly');

% These are for inputs: motion sensor 1 x,y; motion sensor 2 x,y; frame
% clock; stim left; stim right;
% Looks like channel 7 will be for panels x input.
ai_channels_used = [0:7];
aI = s.addAnalogInputChannel('Dev1', ai_channels_used, 'Voltage');
for i=1:length(ai_channels_used)
    aI(i).InputType = 'SingleEnded';
end

% This is the stim control: stim left, stim right
s.addAnalogOutputChannel('Dev1', 0:1, 'Voltage');

% This is the 2p aquisition stop trigger.
%s.addDigitalChannel('Dev1', 'port0/line6', 'OutputOnly');

settings = sensor_settings;

SAMPLING_RATE = settings.sampRate;
s.Rate = SAMPLING_RATE;
total_duration = run_obj.trial_t;
%s.DurationInSeconds = total_duration;

zero_stim = zeros(SAMPLING_RATE*total_duration,1);
stim = zeros(SAMPLING_RATE*total_duration,1);

begin_idx = run_obj.pre_stim_t * SAMPLING_RATE;
end_idx = (run_obj.pre_stim_t+run_obj.stim_t) * SAMPLING_RATE;
stim(begin_idx:end_idx) = 5.0;

imaging_trigger = zero_stim;
imaging_trigger(2:end-1) = 1.0;

output_data = [];

if( strcmp(task, 'Control') == 1 )
    output_data = [imaging_trigger zero_stim zero_stim ];
elseif( strcmp(task, 'ClosedLoop') == 1 )
    output_data = [imaging_trigger zero_stim zero_stim ];
% elseif( strcmp(task, 'RightOdor') == 1 )
%     output_data = [imaging_trigger zero_stim stim ];
% elseif( strcmp(task, 'BothOdor') == 1 )
%     output_data = [imaging_trigger stim stim ];
% elseif( strcmp(task, 'NaturalOdor') == 1 )
%     
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % This is where olfactometer stim parameters are defined.
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     
%     PINCH_VALVE_OPEN_TIME = 1.0;
%     begin_idx = PINCH_VALVE_OPEN_TIME * SAMPLING_RATE;
%     
%     pinch_valve_waveform = zeros(SAMPLING_RATE*total_duration,1);
%     pinch_valve_waveform( begin_idx:end-1 ) = 5.0; % volts
%     
%     output_data = [imaging_trigger pinch_valve_waveform stim ];
    
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% elseif( strncmpi(task, 'sound', 5) == 1 )  %the relevant line in the txt task file needs to start with "sound"
%     % here several entries in the GUI will be ignored (prestim, stim, poststim)
%     fs = 40000;
% 
%     add_s_on = 9; % extra time added (beyond 1 s) before stimulus onset (in seconds); if this value = 1 the stimulus starts at 80000 samples so time = 2 sec
%     add_s_off = 10; % time added after stimulus offset (in seconds)
%     intensity = 2; % output voltage (in V)
%  
%     stim = audioread(['C:\Users\wilson_lab\Desktop\Rachel\auditory_stim_files\' task '.wav']); % load stimulus (the relevant line in the txt task file must be identical to the name of the wav file)
%     stim = intensity/max(abs(stim))*stim;
%     stim = [zeros(1,add_s_on*fs) stim' zeros(1,add_s_off*fs)];
%     
%     zero_stim = zeros(size(stim,2),1);    
%     
%     imaging_trigger = zero_stim;
%     imaging_trigger(2:end-1) = 1.0;
% 
%     % Setup data structures for read / write on the daq board
%     s.Rate = fs;
%     
%     total_duration = size( stim, 2 ) / fs;
%     
%     output_data = [imaging_trigger zero_stim stim' ];
else
    disp(['ERROR: Task: ' task ' is not recognized.']);
end

queueOutputData(s, output_data);

% Begin Panels closed loop

if ( strcmp(task, 'ClosedLoop') == 1 )
    start_position = randi(72); % currently a 7 panel arena
    closedLoop(run_obj.pattern_number, start_position);
end

% Trigger scanimage run if using 2p.
if(run_obj.using_2p == 1)
    scanimage_file_str = ['cdata_' trial_core_name '_tt_' num2str(total_duration) '_'];
    fprintf(scanimage_client, [scanimage_file_str]);
    disp(['Wrote: ' scanimage_file_str ' to scanimage server' ]);
    acq = fscanf(scanimage_client, '%s');
    disp(['Read acq: ' acq ' from scanimage server' ]);    
end

% Delay starting the aquisition for 2 seconds to ensure that scanimage is
% ready and the panels are ready in closed loop. Would be nice to get
% trigger working..!
pause(2.0);

[trial_data, trial_time] = s.startForeground();

release(s);
end

function closedLoop(pattern, startPosition)
%% begins closedLoop setting in panels
Panel_com('stop');
%set arena
Panel_com('set_config_id', 1);
%set brightness level
Panel_com('g_level_7');
%set pattern number
Panel_com('set_pattern_id', pattern);
Panel_com('set_position', [startPosition, 1]);
%set closed loop for x
Panel_com('set_mode', [1, 0]);
gain = -1;
zeropoint = 0;
bias = zeropoint * 20;
Panel_com('send_gain_bias', [10*gain bias 2 0]);
%quiet mode on
Panel_com('quiet_mode_on');
%start pattern
Panel_com('start');
%pause(time);
end
