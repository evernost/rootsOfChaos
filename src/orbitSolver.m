% =============================================================================
% Project       : rootsOfChaos
% Module name   : orbitSolver
% File name     : orbitSolver.m
% Purpose       : tries to find a polynomial with a given orbit property
% Author        : QuBi (nitrogenium@hotmail.com)
% Creation date : Friday, 07 February 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================
%
% DESCRIPTION
% Takes an orbit 'x' (vector) and generates a polynomial 'p' such that 
% - p[x(1)] = x(2)
% - p[x(2)] = x(3)
% - ...
% - p[x(N)] = x(1)
% 
%
% Arguments:
% - orbit [1*N] : list of points defining the cycle
%
% Outputs:
% - p [1*(N-1)] : the polynomial satisfying the orbit condition
%



function p = orbitSolver(orbit)

  %MAX_TRIES = 5000;
  orbitSize = length(orbit);
  
  %for nTry = 1:MAX_TRIES
  
  % Draw a random regularisation (derivative on one of the control points)
  %regLoc = randi([1 orbitSize]);
  %regValue = 0.9*(-1 + 2*rand);
  
  % Form the equation matrix
  M = vander(orbit);
  y = [orbit(2:end), orbit(1)].';
  
  % Solve for the polynomial
  x = M \ y;
  p = x.';
  
  % Measure the orbit stability
  dp = polyder(p);
  s = 1;
  for n = 1:orbitSize
    s = s*polyval(dp, orbit(n));
  end

  if (abs(s) < 1.0)
    %fprintf('[INFO] Stable solution found!\n');
    return
  end
  
  %end
  
  %fprintf('[WARNING] Could not find a stable solution for the requested orbit.\n')
  p = [];

end
