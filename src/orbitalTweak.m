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
  
  orbitSize = length(orbit);

  orbitNew = orbit;
  pNew = p;
  for n = 1:10000
    orbitTest = orbitNew + 0.0001*(-1+2*rand(1, orbitSize));
    pTest = orbitSolver(orbitTest);
    
    if ~isempty(pTest)
      eTest = sum(abs(pTest(1:(orbitSize-3))));
      eNew = sum(abs(pNew(1:(orbitSize-3))));
      if (eTest < eNew)
        orbitNew = orbitTest;
        pNew = pTest;
        %fprintf('[INFO] New score: %0.5f\n', eTest)
      end
    end
  end

  orbitNew
  pNew
end