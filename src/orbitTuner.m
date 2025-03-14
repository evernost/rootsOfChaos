% =============================================================================
% Project       : rootsOfChaos
% Module name   : orbitTuner
% File name     : orbitTuner.m
% Purpose       : wiggles around the orbit until it satisfies several criterias.
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Wednesday, 12 March 2025
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

function [orbitNew, pNew] = orbitTuner(orbit)
  
  % Maximum number of attempts before giving up
  N_TRIES = 500000;
  
  % Number of step length in the random walk
  N_STEPS = 50;

  % Outputs
  orbitNew = orbit;
  pNew = [];
  
  orbitSize = length(orbit);

  condMax = 1e10;
  
  step = logspace(-3,-6,N_STEPS);
  stepIndex = 1;

  status.mean = 0;
  status.minDist = 0;
  status.pScore = 0;

  for n = 1:N_TRIES    
    
    % Tune the orbit a bit, but keep it well defined
    condAttempts = 0; condAcc = 0;
    while 1
      orbitTest = orbitNew + step(stepIndex)*(-1+2*rand(1, orbitSize));
      
      % Detect ill-conditioned orbit
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
    
    % Measure stability
    s = orbitStability(orbitTest, pTest);
  
    if (abs(s) < 1.0)
      if (n == 1)
        status.mean = mean(orbitTest);
        status.minDist = orbitMinDistance(orbitTest);
        status.pScore = orbitSparse(pTest); 
      else
        if ( (abs(mean(orbitTest)) < abs(status.mean)) || ...
             (orbitMinDistance(orbitTest) > status.minDist) )

        
          fprintf('- s = %0.5f\n', s)
          %fprintf('- orbit span = %0.3f ... %0.3f\n', min(orbitNew), max(orbitNew))
          fprintf('- min orbital distance = %0.2f\n', orbitMinDistance(orbitNew))
          fprintf('- mean = %0.3f\n', mean(orbitNew))
          %fprintf('- polynomial sparse = %0.3f\n', orbitSparse(pTest))
          %fprintf('- cond(M) = %0.2f\n', condM)
          %fprintf('- attempts = %d\n', n)

          status.mean = mean(orbitTest);
          status.minDist = orbitMinDistance(orbitTest);
          status.pScore = orbitSparse(pTest);

          orbitNew = orbitTest;
        end
      end
    end
  
  end
  
  warning('a stable solution could not be found (too many attempts)')
  
end