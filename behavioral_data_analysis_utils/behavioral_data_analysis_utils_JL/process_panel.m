function [fr, angle] = process_panel(b_data)
%% REMEMBER
% Pattern x=1 starts eastward most.
% Pattern goes counterclockwise thereafter.
%5 panels = 75;
%7 panels = 105;
settings = sensor_settings;
settings.PANELS_AI = 8;
rawData = b_data(:, settings.PANELS_AI);
maxVal = 5;
minVal = 0;
frames = 72;
initialAngle = 105;
barWidth = 4;
voltsPerStep = (maxVal - minVal)/(frames-1);
fr = round((rawData - minVal)./voltsPerStep);
pixelAngle = 360./96;
arenaAngle = frames*pixelAngle;
angle = (initialAngle-((fr-1)+barWidth/2).*pixelAngle); % need to subtract for the bar width
%% CHECK
angle = wrapTo180(angle);
if arenaAngle < 360
    halfArena = arenaAngle./2;
    indexOver = angle < -halfArena;
    angle = angle + indexOver.*arenaAngle;
end
settings = sensor_settings;
dt = settings.sampRate/settings.sensorPollFreq;
x = floor(length(angle)/dt);
cut_length = x*dt;
angle_downsampled = squeeze(mean(reshape(angle(1:cut_length), [dt, x])));
angle = angle_downsampled;