% Copyright © Rahul Kumar 2020

clear all
close all
clc


% Creating self balancing robot visuals

t = 0:0.1:2*pi;
wheel_geometry = [cos(t)', sin(t)'];                  % outline of wheel
body_geometry = [-0.5, 0; 0.5, 0; 0.5, 6; -0.5, 6;];  % outline of body

hold on;
grid on;
wheelhandle = fill(wheel_geometry(:,1), wheel_geometry(:,2), 'r'); % filling the outline of wheel
bodyhandle = fill(body_geometry(:,1), body_geometry(:,2), 'k');    % filling the outline of body
hold off;

axis([-10 10 -10 10]);                 % Specifying extent of x and y axes
daspect([1 1 1]);                      % Specifying as aspect ratio of X , y and Z axes


% Initialisations

kp = 8.5; kd = 89.68; ki = 0;              % Setting PID constants
M = 0.5; m = 0.2;                        % Mass of body and wheels
 g = 9.8;                        % 
l = .3;                                 % Length of body
F = 0;                                   % Controll Force
x = 0;                                   % Initial position of robot
x_dot = -3;                              % Initial velocity of robot
theta = pi/3;                         % Initial tilt i.e. angle
theta_dot = 0;                           % Initial angular velocity of body
dt = 0.005;                              % Discretizing time
error = 0;                               % Declaring error
prev_error = 0;                          % Declaring prev_error 


% Iterations

tic;                                     % Starting time
while(toc < 10)
    curr_error = (0+theta);
    error = error + curr_error;           % Integrating error over time
    f = kp*(curr_error) + ki*(error) + kd*(curr_error - prev_error );
    prev_error = curr_error;
    
    % Calculation theta_next
    d_theta_dot = (((g*theta*(M+m)-F)/(M*l)))*dt;
    theta_dot = theta_dot + d_theta_dot;
    d_theta = theta_dot*dt;
    theta = theta + d_theta; 
    
    % Calculation of x_next
    d_x_dot = ((F-(1/M)*(m*g*theta)))*dt;
    x_dot = x_dot + d_x_dot ;
    d_x = (x_dot)*dt;
    x = x + d_x;
    
    F =  f;
    
    % If you are using simulation section then comment plottin section and
    % if you are using ploting section then comment simulation section.
    
     % Simulation Section  
  
     % Rotate robot about origin
    rotated_wheel_geometry = wheel_geometry*[cos(-theta) sin(-theta);...
        -sin(-theta), cos(-theta)];
    rotated_body_geometry = body_geometry*[cos(-theta) sin(-theta);...
        -sin(-theta), cos(-theta)];
   
     y_next = 0;              % It will be 0 always
    set(wheelhandle, 'xdata', x+rotated_wheel_geometry(:,1),...
        'ydata', y_next+rotated_wheel_geometry(:,2));
        set(bodyhandle, 'xdata', x+rotated_body_geometry(:,1),...
        'ydata', y_next+rotated_body_geometry(:,2));
 
%     % Plotting section
%     % Plot of tilt and position vs time
%     hold on;
%     subplot(2,1,1);
%     plot(toc,theta,'.b')
%     xlabel('time') ; ylabel('theta');axis([0 10 -pi pi]);title('theta Vs time');
%     hold on;
%     subplot(2,1,2);
%     plot(toc,x,'.r')
%     xlabel('time') ; ylabel('position');axis([0 10 -10 10]);title('position Vs time');
     
     pause(0.0001);
end
