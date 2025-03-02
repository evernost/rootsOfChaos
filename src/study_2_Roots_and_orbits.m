% =============================================================================
% Project       : rootsAndChaos
% Module name   : study_2_Roots_and_orbits
% File name     : study_2_Roots_and_orbits.m
% File type     : Matlab script
% Purpose       : 
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Saturday, 01 March 2025
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

order = 5;
maxPeriod = 3;
nRuns = 5000;

gridSize = 20;
gridMin = -1.2;
gridMax = 1.2;

r = zeros(nRuns, order);
g = linspace(gridMin, gridMax, gridSize);
for n = 1:nRuns
  while 1
    valid = 1;
    
    period = randi([2, maxPeriod]);

    v = g(randperm(gridSize, order+1)).';
    M = vander(v);
    
    lambda = gridMin + (gridMax-gridMin)*rand(order+1-period, 1);
    y = [v(2:period); v(1); lambda];

    p = M \ y;
    rTmp = roots(p);
    
    % INVALID CASE 1: leading coefficient is too small
    if (abs(p(1)) < 0.001)
      valid = 0;
    end
    
    % INVALID CASE 2: multiple roots
    if (length(rTmp) < order)
      valid = 0;
      fprintf('[INFO] Skipping multiple root\n');
    end
    
    d_p = polyder(p);
    s = 1;
    for k = 1:period
      s = s*polyval(d_p, v(k));
    end

    % INVALID CASE 3: orbit is not stable
    if (abs(s) > 1)
      valid = 0;
      %fprintf('[INFO] Skipping unstable orbit\n');
    end


    if (valid == 1)
      r(n,:) = rTmp;
      break
    end
  end
end


scatter(real(r(:)), imag(r(:)), 1);
grid minor

