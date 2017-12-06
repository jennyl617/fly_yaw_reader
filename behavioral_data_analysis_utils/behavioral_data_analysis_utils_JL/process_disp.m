function [ t, disp ] = process_disp( raw_data, time)

settings = sensor_settings;

rate = 2*(settings.cutoffFreq/settings.sampRate);
[kb, ka] = butter(2,rate);
smoothedData = filtfilt(kb, ka, raw_data);

dt = settings.sampRate/settings.sensorPollFreq;

x = floor(length(smoothedData)/dt);
cut_length = x*dt;
smoothedData_downsampled = squeeze(mean(reshape(smoothedData(1:cut_length), [dt, x])));
time_downsampled = squeeze(mean(reshape(time(1:cut_length), [dt, x])));

disp = smoothedData_downsampled;
t = time_downsampled;

end


