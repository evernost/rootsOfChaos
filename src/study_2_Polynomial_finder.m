% =============================================================================
% Project       : rootsOfChaos
% Module name   : study_2_Polynomial_finder
% File name     : study_2_Polynomial_finder.m
% File type     : Matlab script
% Purpose       : hunt for polynomials giving a certain period when recursed
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Sunday, 02 March 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================

% -----------------------------------------------------------------------------
% DESCRIPTION
% -----------------------------------------------------------------------------
% This script tries to find polynomials containing a specific cycle length.
% Only stable orbits are considered as valid solutions.
%
% The order of the candidate polynomials can be adjusted.
%
% Solutions are based on root finding in high order polynomials, so results
% might be inaccurate for high cycle lengths.

close all
clear all
clc



% -----------------------------------------------------------------------------
% SETTINGS
% -----------------------------------------------------------------------------
orbitSize = 6;     % Target orbit size
nSolutions = 10;   % Desired number of solutions

order = 2;        % Max order for the polynomial solution

nPts = 10000;


% -----------------------------------------------------------------------------
% SEARCH LOOP
% -----------------------------------------------------------------------------
nFound = 0;
pList = zeros(1, order+1);
while(nFound < nSolutions)
  
  % Draw a polynomial with random coefficients
  p = -1.0 + 2.0*rand(1, order+1);
  dp = polyder(p);
  
  % Status variable
  % - '-1': solutions, but not stable
  % -  '0': no solution at all
  % -  '1': solution found!
  status = 0;
  
  x = linspace(-1.0, 1.0, nPts); y = x;
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
              
              % Display results
              fprintf('[INFO] Solution %d: p = ', nFound+1);
              for u = 1:(order+1)
                fprintf('%0.8f ', p(u));
              end
              
              r = roots(p);
              fprintf(' - Roots: ');
              for u = 1:length(r)
                fprintf('(%f, %f) ', real(r(u)), imag(r(u)));
              end
              fprintf('\n');
              
              nFound = nFound + 1;
              pList(nFound, :) = p;
              break;
            end
          end
        end
      end
    end
  end
end

% Sort the solutions according to the leading term of the polynomial
[~, idx] = sort(pList(:,1),1);
solutions = pList(idx,:);


% -----------------------------------------------------------------------------
% EMPIRICAL PERIOD ESTIMATION
% -----------------------------------------------------------------------------
% Use xcorr:
% - first peak is always the signal correlated with itself at 0 lag
% - second highest peak relative to the first peak gives the most plausible
%   period (depends on the observation window)

% TODO

% -----------------------------------------------------------------------------
% PLOT THE ROOT LOCUS OF THE SOLUTIONS
% -----------------------------------------------------------------------------

% TODO