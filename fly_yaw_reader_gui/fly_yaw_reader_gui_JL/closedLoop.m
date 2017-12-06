function closedLoop(pattern, startPosition)
%% begins closedLoop setting in panels
%settings = ballSettings();
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
%set gain and bias
%settings.xMinVal = 0.0490;
%settings.xMaxVal = 4.8516;
gain = -1;
%zeropoint = gain*(settings.xMaxVal + settings.xMinVal)/2;
%zeropoint = 2.52500*gain; % zeroed to 150 ml/min.
%zeropoint = 2.5*gain;
zeropoint = 0;
bias = zeropoint * 20;
Panel_com('send_gain_bias', [10*gain bias 2 0]);
%quiet mode on
%Panel_com('quiet_mode_on');
%start pattern
Panel_com('start');
%pause(time);



end