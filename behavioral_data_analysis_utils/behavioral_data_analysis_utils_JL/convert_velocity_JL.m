function [v_fwd,v_side,v_yaw] = convert_velocity_JL(vel_fwd, vel_side, vel_yaw)
%%% converting the velocity signal using the calibration results
%%% Tatsuo Okubo
%%% 2017/01/31

%% parameters
% a_forward = -0.00689;
% a_side = -0.00514;
% a_yaw = 0.000375;

%% revised parameters
a_yaw = .00377*150./100;
a_side = -0.00644;
a_forward = -.00617;

%% convert
v_fwd = vel_fwd./a_forward;
v_side = vel_side./a_side;
v_yaw = vel_yaw./a_yaw;
