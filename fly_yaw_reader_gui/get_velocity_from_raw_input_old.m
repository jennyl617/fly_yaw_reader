function [ vel_in_mm ] = get_velocity_from_raw_input( minVal, maxVal, raw_data, settings )

rate = 2*(settings.cutoffFreq/settings.sampRate);
[kb, ka] = butter(2,rate);
smoothedData = filtfilt(kb, ka, raw_data);

voltsPerStep = (maxVal - minVal)/(settings.numInts - 1);
seq = round((smoothedData - minVal)./voltsPerStep);
%seq = (smoothedData - minVal)./voltsPerStep;
maxInt = settings.numInts -1;
seq(seq>maxInt) = maxInt;
seq(seq<0) = 0;
zeroVal = -1 + (settings.numInts + 1)/2;
seq = seq - zeroVal;

vel_in_mm = seq.*settings.mmPerCount.*settings.sensorPollFreq;

end

