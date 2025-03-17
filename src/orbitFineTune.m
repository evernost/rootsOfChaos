% =============================================================================
% Project       : rootsOfChaos
% Module name   : orbitFineTune
% File name     : orbitFineTune.m
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

function [orbitNew, pNew] = orbitFineTune(orbit)
  
  % Maximum number of attempts before giving up
  N_TRIES = 500000;
  
  % Number of different step sizes in the random walk
  N_STEPS = 50;

  % Maximum condition number allowed
  MAX_COND = 1e10;

  % Maximum tries before declaring that the condition number constraint
  % is too high
  MAX_TRIES_COND = 1000;

  orbitSize = length(orbit);
  
  % Initialise outputs
  orbitNew = orbit;
  pNew = [];
  
  % Initialise step sizes
  step = logspace(-3,-6,N_STEPS);
  stepIndex = 1;

  % Initialise statistics
  orbitStats.solutionCount = 0;
  orbitStats.mean = 0;
  orbitStats.minDist = 0;
  orbitStats.pScore = 0;
  orbitStats.p = [];

  % Solution finding status
  % status = -1: unresolved yet
  % status = 0: valid solution
  % status = -2: failed (not invariant)
  % status = -3: failed (orbit unstable)
  status = -1;



  % ---------
  % MAIN LOOP
  % ---------
  for n = 1:N_TRIES    
    
    status = -1;
    
    % STEP 1: FIND AN INITIAL SETTING WITH A VIABLE CONDITION NUMBER
    condAttempts = 0; condAccu = 0;
    while 1
      
      % Draw an orbit
      orbitTest = orbitNew + step(stepIndex)*(-1+2*rand(1, orbitSize));
      
      % Detect ill-conditioned problem
      M = vander(orbitTest);
      condM = cond(M);
      if (condM < MAX_COND)
        break
      else
        condAttempts = condAttempts + 1;
        condAccu = condAccu + condM;
      end
      
      if (condAttempts > MAX_TRIES_COND)
        fprintf('[ERROR] Target condition number seems unreachable. You should consider adjusting MAX_COND.\n');
        fprintf('[INFO] Observed average condition number: %5e (target: %5e)\n', condAccu/condAttempts, MAX_COND);
        error('Condition number failed to converge.')
      end
    end
    
    
    
    % STEP 2: TEST INTERVAL INVARIANCE
    
    % Solve the polynomial from the candidate orbit
    pTest = orbitSolver(orbitTest);
    
    % Check interval invariance
    if ~intervalInvarianceCheck(pTest, orbitTest)
      status = -2;
    end
    
    
    
    % STEP 3: TEST ORBIT STABILITY
    if (status == -1)
      s = orbitStability(orbitTest, pTest);
    
      %if (abs(s) > 0.85) && (abs(s) < 0.99)
      if (abs(s) < 0.005)
        if (n == 1)
          orbitStats.mean = mean(orbitTest);
          orbitStats.minDist = orbitMinDistance(orbitTest);
          orbitStats.pScore = orbitSparse(pTest); 
          orbitStats.p = pTest;
          
        else
          if ( (abs(mean(orbitTest)) < abs(orbitStats.mean)) || ...
               (orbitMinDistance(orbitTest) > orbitStats.minDist) )

          
            fprintf('- s = %0.5f\n', s)
            fprintf('- min orbital distance = %0.2f\n', orbitMinDistance(orbitNew))
            fprintf('- mean = %0.3f\n', mean(orbitNew))
            
            orbitStats.mean = mean(orbitTest);
            orbitStats.minDist = orbitMinDistance(orbitTest);
            orbitStats.pScore = orbitSparse(pTest);
            orbitStats.p = [orbitStats.p; pTest];
            
            orbitNew = orbitTest;
            pNew = pTest;
          end
        end
        
        orbitStats.solutionCount = orbitStats.solutionCount + 1;
      end
    end
  end

end