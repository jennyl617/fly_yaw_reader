function [ disp_x, disp_y ] = calculate_fly_position_no_yaw(vel_forward, vel_side, dt, last_pos_x, last_pos_y )

disp_x = zeros(1,length(vel_forward));
disp_y = zeros(1,length(vel_forward));

disp_x(1) = last_pos_x;
disp_y(1) = last_pos_y;

for i=2:length(vel_forward)
    disp_x(i) = disp_x(i-1) + vel_side(i-1) * dt;
    disp_y(i) = disp_y(i-1) + vel_forward(i-1) * dt;
end

end

