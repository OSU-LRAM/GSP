function [kappa, joint_loc] = discrete_3_joint_2(s)
% Curvature and integral of curvature for a discrete joint two thirds of the
% way down the body, specified relative to a total body length of 1 unit,
% centered at 1/2
%
% By returning joint_loc as a second output, this basis function instructs
% the integrator to stop and restart at the discontinuity

%joint is at 1/3 way from midpoint to tail end
joint_loc = 0;

% Curvature 
kappa = [dirac(s-joint_loc); heaviside(s-joint_loc)-heaviside(0-joint_loc)];