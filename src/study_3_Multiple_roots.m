% =============================================================================
% Project       : rootsAndChaos
% Module name   : study_3_Multiple_roots
% File name     : study_3_Multiple_roots.m
% File type     : Matlab script
% Purpose       : 
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Sunday, 02 March 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================

% -----------------------------------------------------------------------------
% DESCRIPTION
% -----------------------------------------------------------------------------
% TODO

close all
clear all
clc



% -----------------------------------------------------------------------------
% SETTINGS
% -----------------------------------------------------------------------------

nRuns = 10000;
order = 2;
orbitSize = 4;

nTries = 10000;

for n = 1:nRuns
  
  % Draw a polynomial with random coefficients
  p = -1.0 + 2.0*rand(1, order+1);
  dp = polyder(p);
  
  found = 0;
  yBounds = [-1.0, 1.0];
  x = linspace(-1.0, 1.0, nTries);
  y = x;
  for m = 1:orbitSize
    yBounds = polyval(p, yBounds);
    y = polyval(p,y);
    eq = y - x;
    
    % -------------------------------------------------------------------------
    % ITERATIONS BEFORE THE TARGET ORBIT
    % -------------------------------------------------------------------------
    if (m < orbitSize)
      % Look for a fixed point
      if (yBounds(1)*yBounds(2) < 0)
        signChange = find(eq(1:end-1) .* eq(2:end) < 0);
        if ~isempty(signChange)
          for k = 1:length(signChange)
            x0 = x(signChange(k));

            % The m-th iterate (m < orbitSize) can have a fixed point, but it
            % must not be stable.
            % If it is: discard the polynomial.
            if (abs(polyval(dp,x0)) < 1.0)
              found = -1;
              break;
            end
          end
        end
      end
    
    % -------------------------------------------------------------------------
    % ORBIT ITERATION
    % -------------------------------------------------------------------------
    else  
      % When iterated 'orbitSize' times, the polynomial must have a fixed
      % point.
      % If it doesn't: discard the polynomial.
      if (yBounds(1)*yBounds(2) < 0)
        if (found ~= -1)
          found = 1;
        end
      else
        found = -1;
      end
      
    end
      
      
      
      
  end
  

end
