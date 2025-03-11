% =============================================================================
% Project       : rootsOfChaos
% Module name   : orbitStabiliser
% File name     : orbitStabiliser.m
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

function orbitStabilizer(orbit)
  
  N_TRIES = 500000;

  orbitSize = length(orbit);

  orbitNew = orbit;
  pNew = p;
  eList = zeros(N_TRIES,1);
  sMin = Inf;
  
  step = 10.^-(logspace(-3,-5,N_TRIES));

  for n = 1:N_TRIES    
    orbitTest = orbitNew + step(n)*(-1+2*rand(1, orbitSize));
    
    % Form the equation matrix
    M = vander(orbitTest);
    y = [orbitTest(2:end), orbitTest(1)].';
    
    % Solve for the polynomial
    x = M \ y;
    p = x.';
    
    % Measure the orbit stability
    %dp = polyder(p);
    dp = ((orbitSize-1):-1:1) .* p(1:(end-1));
    s = 1;
    for m = 1:orbitSize
      s = s*polyval(dp, orbit(m));
    end
  
    if abs(s) < sMin
      orbitNew = orbitTest;
      eList(n) = abs(s);
      sMin = abs(s);
      fprintf('[INFO] New s: %0.5f\n', sMin)
      if abs(s) < 1
        fprintf('FOUND!!!\n')
      end
    end
  
  end

  %orbitNew
  %pNew

  %plot(eList)
  %grid on
  %grid minor
end