function [ t, vel ] = get_velocity_from_raw_input( raw_data, time, zero_volt_mark, zero_volt_noise_2std )

settings = sensor_settings;

rate = 2*(settings.cutoffFreq/settings.sampRate);
[kb, ka] = butter(2,rate);
smoothedData = filtfilt(kb, ka, raw_data);

dt = settings.sampRate/settings.sensorPollFreq;

x = floor(length(smoothedData)/dt);
cut_length = x*dt;
smoothedData_downsampled = squeeze(mean(reshape(smoothedData(1:cut_length), [dt, x])));
time_downsampled = squeeze(mean(reshape(time(1:cut_length), [dt, x])));

sdz = smoothedData_downsampled - repmat(zero_volt_mark, [1 size(smoothedData_downsampled,2)]);

noize_level = 1.0*zero_volt_noise_2std;

sdz(find( (sdz < noize_level) & (sdz > -1.0*noize_level))) = 0.0;

vel = sdz;
t = time_downsampled;

end

