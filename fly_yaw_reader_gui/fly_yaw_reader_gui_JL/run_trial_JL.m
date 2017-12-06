function [ trial_data, trial_time ] = run_trial_JL( trial_idx, task, run_obj, scanimage_client, trial_core_name )

disp(['About to start trial task: ' task]);

% Setup data structures for read / write on the daq board
global s = daq.createSession('ni');

% This channel is for external triggering of scanimage 5.1
s.addDigitalChannel('Dev1', 'port0/line0', 'OutputOnly');

% These are for inputs: 1: x disp, 2: yaw disp, 3: y disp, 4: panels
ai_channels_used = [0:3];
aI = s.addAnalogInputChannel('Dev1', ai_channels_used, 'Voltage');
for i=1:length(ai_channels_used)
    aI(i).InputType = 'SingleEnded';
end

% This is the stim control: stim ctl, stim odor
%s.addAnalogOutputChannel('Dev1', 0:1, 'Voltage');

% This is the 2p aquisition stop trigger.
%s.addDigitalChannel('Dev1', 'port0/line6', 'OutputOnly');

settings = sensor_settings_JL;

SAMPLING_RATE = settings.sampRate;
s.Rate = SAMPLING_RATE;
total_duration = run_obj.trial_t;

%zero_stim = zeros(SAMPLING_RATE*total_duration,1);
%stim = zeros(SAMPLING_RATE*total_duration,1);
% begin_idx = run_obj.pre_stim_t * SAMPLING_RATE;
% end_idx = (run_obj.pre_stim_t+run_obj.stim_t) * SAMPLING_RATE;
% stim(begin_idx:end_idx) = 5.0;

imaging_trigger = zeros(SAMPLING_RATE*total_duration,1);
imaging_trigger(2:end-1) = 1.0;

output_data = [];

% if( strcmp(task, 'Control') == 1 )
%     output_data = [imaging_trigger zero_stim zero_stim ];
% elseif( strcmp(task, 'ClosedLoop') == 1 )
%     output_data = [imaging_trigger zero_stim zero_stim ];
% elseif( strcmp(task, 'OpenLoopLeft') == 1 )
%      output_data = [imaging_trigger zero_stim stim ];
% elseif( strcmp(task, 'OpenLoopRight') == 1 )
%      output_data = [imaging_trigger zero_stim stim ];
% else
%     disp(['ERROR: Task: ' task ' is not recognized.']);
% end

output_data = [imaging_trigger];

queueOutputData(s, output_data);

% Trigger scanimage run if using 2p.
if(run_obj.using_2p == 1)
    scanimage_file_str = ['cdata_' trial_core_name '_tt_' num2str(total_duration) '_'];
    fprintf(scanimage_client, [scanimage_file_str]);
    disp(['Wrote: ' scanimage_file_str ' to scanimage server' ]);
    acq = fscanf(scanimage_client, '%s');
    disp(['Read acq: ' acq ' from scanimage server' ]);    
end

% Delay starting the aquisition for 2 seconds to ensure that scanimage is
% ready. Would be nice to get
% trigger working..!

% Begin Panels closed loop

if ( strcmp(task, 'ClosedLoop') == 1 )
    closedLoop(run_obj.pattern_number, run_obj.start_frame);
elseif ( strcmp(task, 'OpenLoop') == 1 )
    openLoop(run_obj.pattern_number, 1, total_duration);
elseif ( strcmp(task, 'OpenLoopRight') == 1 )
    openLoop(run_obj.pattern_number, 1, total_duration);
elseif ( strcmp(task, 'OpenLoopLeft') == 1 )
    openLoop(run_obj.pattern_number, 2, total_duration);
end

Panel_com('start');
[trial_data, trial_time] = s.startForeground();


Panel_com('all_off');
release(s);
end

function closedLoop(pattern, startPosition)
%% begins closedLoop setting in panels
Panel_com('stop');
%set arena
%Panel_com('set_config_id', 1);
%set brightness level
Panel_com('g_level_7');
%set pattern number
Panel_com('set_pattern_id', pattern);
Panel_com('set_position', [startPosition, 1]);
%set closed loop for x
Panel_com('set_mode', [3, 0]);
% gain = 1;
%gain = -.742;
% zeropoint = 0;
% bias = zeropoint * 20;
% Panel_com('send_gain_bias', [10*gain bias 2 0]);
%quiet mode on
Panel_com('quiet_mode_on');
end

function openLoop(pattern, func, time)
%% begins closedLoop setting in panels
freq = 50;
Panel_com('stop');
%set pattern number
Panel_com('set_pattern_id', pattern);
%set closed loop for x
Panel_com('set_mode', [4, 0]);
Panel_com('set_funcx_freq' , freq);
Panel_com('set_posfunc_id', [1, func]);
Panel_com('set_position', [1, 1]);
%quiet mode on
Panel_com('quiet_mode_on');
end