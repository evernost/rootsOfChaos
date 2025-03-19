% =============================================================================
% Project       : rootsOfChaos
% Module name   : orbitStabilizer
% File name     : orbitStabilizer.m
% Purpose       : wiggles around the orbit until it becomes stable
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Tuesday, 11 March 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================
%
% DESCRIPTION
% TODO
% 
% Arguments:
% TODO
%
% Outputs:
% TODO
%

function [orbitNew, pNew] = orbitStabilizer(orbit)
  
  % Maximum number of stabilisation attempts before giving up
  N_TRIES = 10000000;
  
  % Number of step length in the random walk
  N_STEPS = 50;

  % Outputs
  orbitNew = orbit;
  pNew = [];
  
  orbitSize = length(orbit);

  %condMax = 10^(1.6 + orbitSize/2);  % Empirical, based on study_5.
  condMax = 1e10;

  eList = zeros(N_TRIES,1);  
  %step = 10.^-(logspace(-1,-5,N_TRIES));
  %step = logspace(-1,-5,N_STEPS);
  step = logspace(0,-6,N_STEPS);
  stepIndex = 1;
  sMin = Inf;

  bestBounds = [-1000,1000];

  for n = 1:N_TRIES    
    
    % Tune the orbit a bit, but keep it well defined
    condAttempts = 0; condAcc = 0;
    while 1
      orbitTest = orbitNew + step(stepIndex)*(-1+2*rand(1, orbitSize));
      
      % Detect and avoid ill-conditioned orbits
      M = vander(orbitTest);
      condM = cond(M);
      if (condM < condMax)
        break
      else
        condAttempts = condAttempts + 1;
        condAcc = condAcc + condM;
      end
      
      if (condAttempts > 1000)
        fprintf('[ERROR] Target condition number seems unreachable. You should consider adjust it.\n');
        fprintf('Observed average condition number: %5e (target: %5e)\n', condAcc/condAttempts, condMax);
        error('Condition number failed to converge.')
      end

    end
    
    % Solve the polynomial from the candidate orbit
    pTest = orbitSolver(orbitTest);
    
    % Check interval invariance
    [invarTest, bounds] = intervalInvarianceCheck(pTest, orbitTest);

    if (bounds(2) - bounds(1)) < (bestBounds(2) - bestBounds(1))
      bestBounds = bounds;
      disp(bestBounds)
    end

    if invarTest

      % Measure stability
      s = orbitStability(orbitTest, pTest);
    
      if (abs(s) < sMin)
        % Register the solution
        orbitNew = orbitTest;
        pNew = pTest;
        sMin = abs(s);
        
        % Adjust step
        stepIndex = min(N_STEPS, stepIndex+1);
  
        eList(n) = abs(s);
        fprintf('[INFO] s = %0.5f - step = %0.5f\n', sMin, step(stepIndex))
        
        if (abs(s) < 1.0)
          fprintf('[INFO] Stable solution found!\n')
          fprintf('- s = %0.5f\n', s)
          fprintf('- orbit span = %0.3f ... %0.3f\n', min(orbitNew), max(orbitNew))
          fprintf('- min orbital distance = %0.2f\n', orbitMinDistance(orbitNew))
          fprintf('- mean = %0.3f\n', mean(orbitNew))
          fprintf('- cond(M) = %0.2f\n', condM)
          fprintf('- attempts = %d\n', n)
          fprintf('\n')
          return
        end
      end
    
    else
      % TODO: detect too many failed attempts
      % 
    
    end
  
  end
  
  warning('a stable solution could not be found (too many attempts)')
  orbitNew = [];
  pNew = [];
  
end