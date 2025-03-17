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

% TODO: try to specify a target work interval instead of adapting to the orbit


function out = intervalInvarianceCheck(p, orbit)
  
  % Number of points in the analysis grid
  N_PTS = 1000;

  x = linspace(1.01*min(orbit), 1.01*max(orbit), N_PTS);

  for n = 1:5
    y = polyval(p,x);

    if ((min(y) < -100) || (max(y) > 100))
      %fprintf('[INFO] Invariance check failed.\n');
      out = false;
      return
    else
      x = linspace(min(y), max(y), 1000);
    end
  end

  out = true;
  
end