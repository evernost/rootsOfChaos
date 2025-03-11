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
  
  %M = vander(orbit);
  condMax = 1e4;
  
  eList = zeros(N_TRIES,1);
  orbitSize = length(orbit);
  step = 10.^-(logspace(-3,-5,N_TRIES));
  sMin = Inf;
  for n = 1:N_TRIES    
    
    % Tune the orbit a bit, but keep it well defined
    while 1
      orbitTest = orbitNew + step(n)*(-1+2*rand(1, orbitSize));
      
      % Detect ill-conditioned orbit
      M = vander(orbit);
      if cond(M) < condMax
        break
      end
    end
    
    pTest = orbitSolver(orbit);
    
    % Measure stability
    s = orbitStability(orbitTest, pTest);
  
    if (abs(s) < sMin)
      orbitNew = orbitTest;
      eList(n) = abs(s);
      sMin = abs(s);
      fprintf('[INFO] New s: %0.5f\n', sMin)
      
      if (abs(s) < 1.0)
        fprintf('[INFO] Stable solution found!\n')
        return
      end
    end
  
  end
  
  fprintf('[WARNING] orbitStabilizer: stable solution could be found (timeout)\n')
  

  %orbitNew
  %pNew

  %plot(eList)
  %grid on
  %grid minor
end