% =============================================================================
% Project       : rootsOfChaos
% Module name   : study_4_Orbit_transition
% File name     : study_4_Orbit_transition.m
% File type     : Matlab script
% Purpose       : study on the 'proper' way to interpolate between polynomials
%                 of different cycle length
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Sunday, 09 March 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================

% -----------------------------------------------------------------------------
% DESCRIPTION
% -----------------------------------------------------------------------------
% TODO

close all
clear all
clc



% -----------------------------------------------------------------------------
% CONSTANTS
% -----------------------------------------------------------------------------
% These solutions were found using 'study_2_Polynomial_finder.m'
% TODO: pick polynomials such that the orbit is 'as far as possible' to an 
% orbit of lower length
p = zeros(5, 3);
p(1,:) = [0.0, -1.0, -0.50345035];
p(2,:) = [-1.84281682, -0.68078575, 0.70764308];  % 3rd order solution
p(3,:) = [0.86064152 -0.74091127 -0.97823178];    % 4th order
p(4,:) = [0.93063441 -0.99468189 -0.95280262];    % 5th order
p(5,:) = [0.88245011 -0.94035343 -0.76743165];    % 6th order



% -----------------------------------------------------------------------------
% SETTINGS
% -----------------------------------------------------------------------------
nSolutions = size(p,1);

observationTime = 100;
transitionTime = 50;

xInit = 0.2;



% -----------------------------------------------------------------------------
% MAIN LOOP
% -----------------------------------------------------------------------------
nPts = 1 + nSolutions*(observationTime + transitionTime);
x = zeros(nPts, 1);
x(1) = xInit; t = 2;
for s = 1:nSolutions
  for n = 1:observationTime
    x(t) = polyval(p(s,:), x(t-1));
    t = t + 1;
  end
end
