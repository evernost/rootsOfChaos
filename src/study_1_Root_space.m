% =============================================================================
% Project       : rootsAndChaos
% Module name   : study_1_Root_space
% File name     : study_1_Root_space.m
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
nRuns = 5000;

gridSize = 21;
gridMin = -1.2;
gridMax = 1.2;

cMap = hot(4);
r = zeros(nRuns, order);
rColor = zeros(nRuns, 3);
nOrbit = zeros(nRuns, 1);
x = linspace(gridMin, gridMax, gridSize);
for n = 1:nRuns
  while 1
    p = x(randi([1, gridSize], 1, order + 1));
    valid = 1;
    rColor(n, :) = [0.5, 0.5, 1.0];
    
    % INVALID CASE 1: leading coefficient is too small
    if (abs(p(1)) < 0.001)
      %fprintf('[INFO] Skipping polynomial with weak leading coefficient\n');
      valid = 0;
    end
    
    % INVALID CASE 2: multiple roots
    rTmp = roots(p);
    if (length(rTmp) < order)
      %fprintf('[INFO] Skipping multiple roots\n');
      valid = 0;
    end
    
    for k = 1:4
      nFixed = countFixedPoints(p,k);
      if nFixed > nOrbit(n)
        nOrbit(n) = k;
      end
    end
    
    if (nOrbit(n) > 0)
      rColor(n,:) = cMap(nOrbit(n), :);
    end
    
    if (valid == 1)
      r(n,:) = rTmp;
      break
    end
  end
end


scatter(real(r(:)), imag(r(:)), [], kron(rColor, ones(order,1)), '.')
grid minor

