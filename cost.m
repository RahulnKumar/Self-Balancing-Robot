function [cost] = error(kp, kd)
%close all
%clear all
clc

% Initialisations

ki = 0;                                  % Setting k = 0 as it is pd controller
M = 0.5; m = 0.2;                        % Mass of body and wheels
g = 9.8;                                 % Acceleration due to gravity
l = 0.3;                                 % Length of body
F = 0;                                   % Control Force
x = 0;                                   % Initial position of robot
x_dot = 0;                               % Initial velocity of robot
theta = pi/10;                           % Initial tilt i.e. angle
theta_dot = 0;                           % Initial angular velocity of body
dt = 0.005;                              % Discretizing time
error = 0;                               % Declaring error
prev_error = 0;                          % Declaring prev_error
cost = 0;

% Iterations
t=0;
while(t < 10)
    curr_error = (0+theta);
    error = error + curr_error;
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
    
    % The controller
    F = f;                 
    
    cost = abs(theta) + cost;

     t = t+dt ;
end