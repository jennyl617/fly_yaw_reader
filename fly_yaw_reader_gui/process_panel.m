function [fr, angle] = process_panel(trial_data, frames)
%% REMEMBER
% Pattern x=1 starts eastward most.
% Pattern goes counterclockwise thereafter.
%5 panels = 75;
%7 panels = 105;

rawData = trial_data(:,7);

initialAngle = 105;
maxVal = 5;
minVal = 0;
voltsPerStep = (maxVal - minVal)/(frames-1);
fr = round((rawData - minVal)./voltsPerStep);
pixelAngle = 360./96;
arenaAngle = frames*pixelAngle;
angle = (initialAngle-((fr-1)+stim.barWidth/2).*pixelAngle); % need to subtract for the bar width
%% CHECK
angle = wrapTo180(angle);
if arenaAngle < 360
    halfArena = arenaAngle./2;
    indexOver = angle < -halfArena;
    angle = angle + indexOver.*arenaAngle;
end