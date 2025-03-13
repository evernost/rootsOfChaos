% =============================================================================
% Project       : rootsOfChaos
% Module name   : orbitSparse
% File name     : orbitSparse.m
% Purpose       : measure orbit degeneration
% Author        : QuBi (nitrogenium@hotmail.com)
% Creation date : Wednesday, 12 March 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================
%
% DESCRIPTION
% Measures the relative weight of the highest coefficients in a polynomial
% Used to determined how far the input polynomial is from a second
% order polynomial.
% 
% Arguments:
% TODO
%
% Outputs:
% TODO
%

function s = orbitSparse(p)
  
  nTerms = length(p);
  nMax = nTerms-3;
  
  w = 2.^(nMax:-1:1);
  s = abs(p(1:nMax)) * w.';

end
