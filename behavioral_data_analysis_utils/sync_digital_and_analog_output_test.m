%% Synchronous analog and digital output test

SR = 4000;

sa = daq.createSession('ni');
sa.addDigitalChannel('Dev1', 'port0/line0', 'OutputOnly');
sa.addAnalogInputChannel('Dev1', 0:6, 'Voltage');
sa.addAnalogOutputChannel('Dev1', 0:1, 'Voltage');
sa.Rate =  SR;

output1 = zeros(SR*6,1);
output1(1*SR:2*SR) = 1.0;

output2 = zeros(SR*6,1);
output2(3*SR:4*SR) = 1.0;

output3 = zeros(SR*6,1);
output3(2:end-1) = 1.0;

%sd = daq.createSession('ni');
%sd.addDigitalChannel('Dev1', 'port0/line0', 'OutputOnly');
%sd.Rate =  SR;

%sa.addTriggerConnection('Dev1/PFI1', 'External', 'StartTrigger');
%sd.addTriggerConnection('External', 'Dev1/PFI2', 'StartTrigger');

queueOutputData(sa, [ output3 output2 output1 ]);
%queueOutputData(sd, [ output3 ]);

%sd.startBackground;
[trial_data, trial_time] = sa.startForeground;

sa.release();