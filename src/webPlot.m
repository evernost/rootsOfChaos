% =============================================================================
% Project       : rootsOfChaos
% Module name   : webPlot
% File name     : webPlot.m
% Purpose       : cobweb plot of a polynomial recursion
% Author        : QuBi (nitrogenium@hotmail.com)
% Creation date : Wednesday, 05 March 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================
%
% DESCRIPTION
% Plots the polynomial 'p' evaluated on the vector 'x'.
% At the same time, the plot shows the web plot of a recursive map 
% with polynomial 'p' in the recurrence relation.
% 'xInit' defines the start point, 'n' the number of iterations.
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

% TODO: generalise to other kind of functions


function webPlot(p, x, xInit, n)
  
  y = polyval(p,x);

  figure
  plot(x,y, x,x)
  grid minor
  
  u = xInit; v = polyval(p, xInit);
  line([u, u], [0, v], 'Color', 'k');
  line([u, v], [v, v], 'Color', 'k');
  
  for iter = 1:n
    u = xInit; v = polyval(p, u);
    line([u, u], [u, v], 'Color', 'k');
    line([u, v], [v, v], 'Color', 'k');
  end
  
end

