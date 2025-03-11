% =============================================================================
% Project       : rootsOfChaos
% Module name   : orbitStabilizer
% File name     : orbitStabilizer.m
% Purpose       : wiggles around the orbit until it becomes stable
% Author        : QuBi (nitrogenium@hotmail.com)
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
  N_TRIES = 500000;
  
  % Outputs
  orbitNew = orbit;
  pNew = [];
  
  orbitSize = length(orbit);

  condMax = 10^(1.38 + orbitSize/2);
  eList = zeros(N_TRIES,1);  
  step = 10.^-(logspace(-1,-5,N_TRIES));
  sMin = Inf;
  for n = 1:N_TRIES    
    
    % Tune the orbit a bit, but keep it well defined
    condAttempts = 1;
    while 1
      
      % TODO: wrong! the step must change only if a good result is obtained
      orbitTest = orbitNew + step(n)*(-1+2*rand(1, orbitSize));
      
      % Detect ill-conditioned orbit
      M = vander(orbit);
      if cond(M) < condMax
        %fprintf('[INFO] Proper matrix found (attempts = %d, cond = %0.1f)\n', condAttempts, cond(M))
        break
      else
        condAttempts = condAttempts + 1;
      end
    end
    
    pTest = orbitSolver(orbit);
    
    % Measure stability
    s = orbitStability(orbitTest, pTest);
  
    if (abs(s) < sMin)
      orbitNew = orbitTest;
      eList(n) = abs(s);
      sMin = abs(s);
      fprintf('[INFO] s = %0.5f\n', sMin)
      
      if (abs(s) < 1.0)
        fprintf('[INFO] Stable solution found! s = %0.5f, cond(M) = %0.3f\n', s, cond(M))
        fprintf('- s = %0.5f\n', s)
        fprintf('- cond(M) = %0.2f\n', cond(M))
        fprintf('- attempts = %d\n', n)
        fprintf('\n')
        return
      end
    end
  
  end
  
  warning('a stable solution could not be found (too many attempts)\n')
  
end