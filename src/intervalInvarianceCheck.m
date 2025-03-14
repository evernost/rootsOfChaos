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

function out = intervalInvarianceCheck(p, orbit)
  
  x = linspace(min(orbit), max(orbit), 1000);
  y = polyval(p,x);

  unstableInterval = ((min(y) < 1.2*min(orbit)) || (max(y) > 1.2*max(orbit)));

  out = ~unstableInterval;
  
end