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
% Estimates the stability of an orbit in a polynomial 'p' by evaluating its 
% derivative on all points in the orbit and taking their product.
%
% Stability is granted when this product is less than 1 in magnitude.
%
% Note: the function does not verify that the given orbit is actually an 
%       orbit for 'p'.
% 
% Arguments:
% TODO
%
% Outputs:
% TODO
%

function [s, sup] = orbitStability(orbit, p)
  
  orbitSize = length(orbit);
  
  % Direct computation of the derivative seems 
  % more efficient that polyder, for some reason.
  %dp = polyder(p);
  dp = ((orbitSize-1):-1:1) .* p(1:(end-1));
  
  s = 1;
  sup = 0;
  for m = 1:orbitSize
    mul = polyval(dp, orbit(m));

    sup = sup + abs(mul);

    % if (abs(mul) > sup)
    %   sup = abs(mul);
    % end


    s = s*mul;
  end
end
