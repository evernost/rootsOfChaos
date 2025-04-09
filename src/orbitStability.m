% =============================================================================
% Project       : rootsOfChaos
% Module name   : orbitStability
% File name     : orbitStability.m
% Purpose       : evaluates the stability of an orbit contained in a polynomial
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Tuesday, 11 March 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================
%
% DESCRIPTION
% Estimates the stability of an orbit in a polynomial 'p' by evaluating the 
% product of the derivative on all points in the orbit.
%
% Stability is granted when this product is less than 1 in magnitude.
%
% The function also returns the value of all derivatives in a vector, so 
% that it is possible to apply stronger criterias on the solutions
% (overall lower values for the derivatives seems linked to the convergence
% speed to the orbit)
%
%
%
% Note: the function does not verify that the given orbit is actually an 
%       orbit for 'p'.
% 
% Arguments:
% TODO
%
% Outputs:
% - s           [1*1] : product of all derivatives on the orbit points
% - derivVect  [1*1] : the polynomial satisfying the orbit condition
%

function [s, derivVect] = orbitStability(orbit, p)
  
  orbitSize = length(orbit);
  
  % Direct computation of the derivative seems 
  % more efficient than 'polyder', for some reason.
  %dp = polyder(p);
  dp = ((orbitSize-1):-1:1) .* p(1:(end-1));
  
  s = 1;
  derivVect = zeros(orbitSize,1);
  for m = 1:orbitSize
    derivVect(m) = polyval(dp, orbit(m));
    s = s*derivVect(m);
  end
end
