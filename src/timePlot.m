% =============================================================================
% Project       : rootsOfChaos
% Module name   : timePlot
% File name     : timePlot.m
% Purpose       : plot time series of a map using a polynomial as recursion
% Author        : QuBi (nitrogenium@hotmail.com)
% Creation date : Wednesday, 05 March 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================
%
% DESCRIPTION
% TODO
%
% Arguments:
% - x     [1*nPts]  : the range on which the polynomial 'p' will be evaluated
% - p     [1*pSize] : any polynomial
% - xInit [1*1]     : starting point
% - n     [1*1]     : how many iterations
%
% Outputs:
% None.
%



function timePlot(p, xInit, nPts)
  
  x = zeros(nPts,1);
  x(1) = xInit;
  for k = 2:nPts
    x(k) = polyval(p, x(k-1));
  end

  figure
  plot(x)
  grid minor
  
end
