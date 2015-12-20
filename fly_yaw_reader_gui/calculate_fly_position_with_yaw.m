function [ disp_x, disp_y, theta ] = calculate_fly_position_no_yaw(vel_forward, vel_side, vel_yaw, dt, last_pos_x, last_pos_y, last_theta)

disp_x = zeros(1,length(vel_forward));
disp_y = zeros(1,length(vel_forward));
theta = zeros(1,length(vel_forward));

disp_x(1) = last_pos_x;
disp_y(1) = last_pos_y;
theta(1) = last_theta;

for i=2:length(vel_forward)
    cur_theta = theta(i-1) + vel_yaw(i-1) * dt; 
    theta(i) = cur_theta;
    
    disp_x(i) = disp_x(i-1) + (vel_side(i-1)*cos(cur_theta) - vel_forward(i-1)*sin(cur_theta)) * dt;
    disp_y(i) = disp_y(i-1) + (vel_side(i-1)*sin(cur_theta) + vel_forward(i-1)*cos(cur_theta)) * dt;
end

end

