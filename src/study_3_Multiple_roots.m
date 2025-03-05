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
nRuns = 100000;
order = 2;
orbitSize = 10;

nTries = 10000;

nFound = 0;
pList = zeros(1, order+1);

for n = 1:nRuns
  
  % Draw a polynomial with random coefficients
  p = -1.0 + 2.0*rand(1, order+1);
  dp = polyder(p);
  
  % Status variable
  % - '-1': solutions, but not stable
  % -  '0': no solution at all
  % -  '1': solution found!
  status = 0;
  
  x = linspace(-1.0, 1.0, nTries); y = x;
  for m = 1:orbitSize
    y = polyval(p,y);
    
    [z, zDeriv, zInd, nFix] = fixedPointAnalysis(p, x, y);
    
    % -------------------------------------------------------------------------
    % ITERATIONS BEFORE THE TARGET ORBIT
    % -------------------------------------------------------------------------
    if (m < orbitSize)
      
      % The m-th iterate (m < orbitSize) can have a fixed point, but it
      % must not be stable.
      % If it is: discard the polynomial.
      for k = 1:nFix
        s = 1; x0 = z(k);
        for t = 1:m
          s = s*abs(polyval(dp,x0));
          x0 = polyval(p,x0);
        end
      
        % Any stable fixed point here invalidates the candidate 
        % polynomial
        if (s < 1.0)
          status = -1;
          break;
        end
      end
      
    % -------------------------------------------------------------------------
    % LAST ITERATION (TOTAL ORBIT)
    % -------------------------------------------------------------------------
    else
    
      % When iterated 'orbitSize' times, the polynomial must have 1 and only 
      % 1 stable fixed point.
      if (nFix == 0)
        status = -1;
      
      else
        if (status ~= -1)
          for k = 1:nFix
            s = 1; x0 = z(k);
            for t = 1:nFix
              s = s*abs(polyval(dp,x0));
              x0 = polyval(p,x0);
            end
            
            % Stable fixed point found!
            if (s < 1.0)
              status = 1;
              
              % TODO: show coefficients with more precision
              fprintf('[INFO] Found! p = \n');
              disp(p);

              nFound = nFound + 1;
              pList(nFound, :) = p;
            end
          end
        end
      end
    end
  end
end

% Plot the solutions
%plot(