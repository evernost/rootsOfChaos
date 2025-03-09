% =============================================================================
% Project       : rootsOfChaos
% Module name   : orbitalTweak
% File name     : orbitalTweak.m
% Purpose       : wiggles around the orbit until the leading coefficients
%                 get much closer to 0
% Author        : QuBi (nitrogenium@hotmail.com)
% Creation date : Sunday, 09 March 2025
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

function orbitalTweak(p, orbit)
  
  N_TRIES = 5000000;

  orbitSize = length(orbit);

  orbitNew = orbit;
  pNew = p;
  eList = zeros(N_TRIES,1);
  w = 2.^(linspace(4,0,orbitSize-3));
  for n = 1:N_TRIES
    orbitTest = orbitNew + 0.001*(-1+2*rand(1, orbitSize));
    pTest = orbitSolver(orbitTest);
    
    if ~isempty(pTest)
      eTest = sum(abs(pTest(1:(orbitSize-3)) .* w));
      eNew  = sum(abs(pNew(1:(orbitSize-3)) .* w));
      if (eTest < eNew)
        orbitNew = orbitTest;
        pNew = pTest;
        eList(n) = eNew;
        %fprintf('[INFO] New score: %0.5f\n', eTest)
      end
    end
  end

  orbitNew
  pNew

  plot(eList)
  grid on
  grid minor
end