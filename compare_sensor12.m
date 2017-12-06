%%% analyzing calibration
%%% Tatsuo Okubo
%%% 2017/01/06

clear;
experiment_dir = '\\research.files.med.harvard.edu\Neurobio\Wilson Lab\Jenny\FSB\Data\Behavior\ball_calibration_2\yaw';
%experiment_dir = 'X:\Jenny\FSB\Data\Behavior\ball_calibration_3\yaw'
use_calibration = 0;
cd(experiment_dir)
Dir = dir('*sid*');
Sessions = (0:6);

%%
settings = sensor_settings;
clf;
figure(1); 
for n=1:length(Sessions)
    File = dir(['*sid_',num2str(Sessions(n)),'_*']);
    File;
    load(File.name);
    
    plot(trial_time, trial_bdata(:,1), 'r');
    hold on;
    plot(trial_time, trial_bdata(:,3), 'b');
    hold on;
end

figure(2);
test = [];
for n=1:length(Sessions)
    File = dir(['*sid_',num2str(Sessions(n)),'_*']);
    File;
    load(File.name);
    
    test = [test (trial_bdata(:,1)-trial_bdata(:,3))'];

    hold on;
end
histogram(test);
prctile(test,5)
prctile(test,95)
ylabel('Voltage');
xlabel('Time');