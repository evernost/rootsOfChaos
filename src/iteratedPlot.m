% =============================================================================
% Project       : rootsOfChaos
% Module name   : iteratedPlot
% File name     : iteratedPlot.m
% Purpose       : plot the n-th iterate of a function
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



function iteratedPlot(p, x, order)
  
  y = x;
  for n = 1:order
    y = polyval(p,y);
  end

  figure
  plot(x,y, x,x)
  grid minor
  
end
