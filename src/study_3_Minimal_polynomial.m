% =============================================================================
% Project       : rootsOfChaos
% Module name   : study_3_Minimal_polynomial
% File name     : study_3_Minimal_polynomial.m
% File type     : Matlab script
% Purpose       : tries to find the minimal polynomial for a given orbit
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Thursday, 06 March 2025
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
nTarget = 30;
orbitSize = 5;

gridSize = 50000;
g = linspace(-1.0, 1.0, gridSize);


% -----------------------------------------------------------------------------
% FIRST APPROACH: RANDOM
% -----------------------------------------------------------------------------
nSol = 0;
orbits = zeros(nTarget, orbitSize);
pSol = zeros(nTarget, orbitSize+1);
while (nSol < nTarget)
  
  % Draw a random orbit
  orbit = g(randperm(gridSize, orbitSize));
  
  % Solve
  p = orbitSolver(orbit);
  
  if (~isempty(p))
    if (abs(p(1)) < 3.0)
      nSol = nSol + 1;
      disp('Found!')
      pSol(nSol, :) = p
      orbits(nSol, :) = orbit;
    else
      fprintf('[INFO] Stable solution, but leading term = %0.2f\n', p(1));
    end
  end
end
  
  
  
