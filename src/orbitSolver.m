% =============================================================================
% Project       : rootsOfChaos
% Module name   : orbitSolver
% File name     : orbitSolver.m
% Purpose       : tries to find a polynomial with a given orbit property
% Author        : QuBi (nitrogenium@hotmail.com)
% Creation date : Friday, 07 March 2025
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
% Note: use the 'orbitStability' function to check if the solution is
%       stable.
%
% ARGUMENTS
% - orbit [1*N] : list of points defining the cycle
%
% OUTPUTS
% - p [1*(N-1)] : the polynomial satisfying the orbit condition
%

function [p, condNumber] = orbitSolver(orbit)
  
  % Form the equation matrix
  M = vander(orbit);
  y = [orbit(2:end), orbit(1)].';
  
  % Solve for the polynomial
  x = M \ y;
  p = x.';
  
  % Return the condition number
  condNumber = cond(M);
  
end
