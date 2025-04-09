% =============================================================================
% Project       : rootsOfChaos
% Module name   : intervalInvarianceCheck
% File name     : intervalInvarianceCheck.m
% Purpose       : tests if an interval is stable under the action of a
%                 polynomial
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Friday, 14 March 2025 (pi day!)
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================
%
% DESCRIPTION
% Determines the image of an interval by a polynomial.
%
% Let 'I' be the smallest interval containing the entire orbit. 
% Then p(I) must be contained in 'I' otherwise any slight deviation
% from the orbit could send you to the Moon.
% 
% Arguments:
% TODO
%
% Outputs:
% TODO
%



function [testResult, bounds] = intervalInvarianceCheck(p, orbit)
  
  % Number of points in the analysis grid
  N_PTS = 1000;

  % Define the interval 'I' (here: the minimal segment containing the orbit +5%)
  x = linspace(1.05*min(orbit), 1.05*max(orbit), N_PTS);

  % Iterate a few times on 'I'
  for n = 1:5
    y = polyval(p,x);
    
    if (n == 1)
      bounds = [min(y), max(y)];
    end

    if ((min(y) < -100) || (max(y) > 100))
      testResult = false;
      return
    end
    
    x = linspace(min(y), max(y), N_PTS);
  end

  % Iteration did not seem to blow up
  bounds = [min(y), max(y)];
  testResult = true;
end

