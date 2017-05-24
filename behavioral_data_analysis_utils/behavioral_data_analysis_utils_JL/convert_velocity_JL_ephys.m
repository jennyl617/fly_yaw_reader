function [v_fwd,v_side,v_yaw] = convert_velocity_TO_ephys(vel_fwd, vel_side, vel_yaw)
%%% converting the velocity signal using the calibration results
%%% Tatsuo Okubo
%%% 2017/01/31

%% parameters
a_forward = 0.00631;

a_side = 0.00947;

a_yaw = 0.000449;

%% convert
v_fwd = vel_fwd./a_forward;
v_side = vel_side./a_side;
v_yaw = vel_yaw./a_yaw;
