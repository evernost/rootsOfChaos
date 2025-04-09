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
% This script draws random orbits of a given size, until a valid polynomial
% containing this orbit is found, i.e. a polynomial satisfying:
% - the orbit is stable (attractive period)
% - the leading coefficients are close to 0
%
% The goal is to see how much a polynomial can be reduced (in terms of
% degree) when the orbit is chosen carefully enough.
% 
% Orbit is drawn randomly on a grid on the real axis, so that it is easier
% to enforce it to contain strict different values.
%
% The script halts when it found the requested number of solutions.

close all
clear all
clc



% -----------------------------------------------------------------------------
% SETTINGS
% -----------------------------------------------------------------------------
orbitSize = 11;   % Target orbit size
nSolutions = 5;   % Desired number of solutions

orbitRange = [-2.5, 2.5];



% -----------------------------------------------------------------------------
% MAIN LOOP
% -----------------------------------------------------------------------------
nFound = 0;
orbits = zeros(nSolutions, orbitSize);
pSol = zeros(nSolutions, orbitSize);

while (nFound < nSolutions)
  
  % Draw a random orbit
  fprintf('[STEP 1] Draw a random orbit\n');
  orbit = orbitRange(1) + (orbitRange(2) - orbitRange(1))*rand(1, orbitSize);
  
  % Try to find a stable solution 
  fprintf('[STEP 2] Tune the orbit for stability and invariance\n');
  [orbitStable, p] = orbitStabilizer(orbit);

  % Optimize the polynomial for better convergence
  if ~isempty(p)
    fprintf('[STEP 3] Fine tune the orbit for better convergence\n');
    [orbitNew, pNew] = orbitFineTune(orbitStable);
  end

  nFound = nFound + 1;
  pSol(nFound, :) = pNew;
  orbits(nFound, :) = orbitNew;
end



% -----------------------------------------------------------------------------
% REARRANGE SOLUTIONS
% -----------------------------------------------------------------------------
% % Sort the solutions based on the second leading term
% [~, idx] = sort(pSol(:,2));
% pSolSorted = pSol(idx,:);
% orbitsSorted = orbits(idx,:);
% 
% % Force the highest value in the orbit first (using circular shift)
% % This makes the orbit comparison easier
% z = orbits;
% for n = 1:nSolutions
%   [~, maxIdx] = max(orbits(n,:),[],2);
%   z(n,:) = circshift(orbits(n,:), -maxIdx+1,2);
% end



% -----------------------------------------------------------------------------
% EVALUATE SOLUTIONS WITH THEIR LEADING TERMS CANCELLED
% -----------------------------------------------------------------------------
% Solutions have been found. 
% By construction, their leading coefficients are close to 0.
% If their coefficients are actally cancelled, do they still contain a
% stable orbit with the original orbit size?
% 
% TODO!
%

