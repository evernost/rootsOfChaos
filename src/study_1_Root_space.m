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

order = 3;
nRuns = 5000;


gridSize = 6;
gridMin = -1.2;
gridMax = 1.2;


r = zeros(nRuns, order);

x = linspace(-1, 1, gridSize);
for n = 1:nRuns
  while 1
    valid = 1;
    p = x(randi([1, gridSize], 1, order+1));
    rTmp = roots(p);
    
    % INVALID CASE 1: leading coefficient is too small
    if (abs(p(1)) < 0.01)
      valid = 0;
    end
    
    % INVALID CASE 2: multiple roots
    if (length(rTmp) < order)
      valid = 0;
      sprintf('Double root found! \n');
    end
    
    if (valid == 1)
      r(n,:) = rTmp;
      break
    end
  end
end

cMap = jet(nRuns);
c = zeros(order*nRuns, 2);
for n = 1:nRuns
  for o = 1:order
    c((n-1)*order + o, 1) = r(n, order);
    c((n-1)*order + o, 2) = cMap(n);
  end
end
scatter(real(c(:,1)), imag(c(:,1)), 1, c(:,2));
grid minor

