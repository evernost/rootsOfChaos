% =============================================================================
% Project       : rootsOfChaos
% Module name   : N/A
% File name     : study_6_Orbit_degeneration.m
% File type     : Matlab script
% Purpose       : 
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Thursday, 13 March 2025
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
orbitSize = 11;   % Target orbit size
nSolutions = 5;   % Desired number of solutions

orbitRange = [-1.0 1.0];



% -----------------------------------------------------------------------------
% MAIN LOOP
% -----------------------------------------------------------------------------
nFound = 0;
orbits = zeros(nSolutions, orbitSize);
pSol = zeros(nSolutions, orbitSize);
fprintf('[INFO] Looking for solutions...\n');
while (nFound < nSolutions)
  
  % Draw a random orbit
  while 1
    orbit = orbitRange(1) + (orbitRange(2) - orbitRange(1))*rand(1, orbitSize);
    
    if (orbitMinDistance(orbit) >= 0.01)
      break
    end
  end
  
  % Try to find a stable solution 
  [orbitStable, p] = orbitStabilizer(orbit);

  % Degenerate the solution by quantizing the polynomial coefficients
  disp('test')
end
  


% -----------------------------------------------------------------------------
% REARRANGE SOLUTIONS
% -----------------------------------------------------------------------------
% Sort the solutions based on the second leading term
[~, idx] = sort(pSol(:,2));
pSolSorted = pSol(idx,:);
orbitsSorted = orbits(idx,:);

% Force the highest value in the orbit first (using circular shift)
% This makes the orbit comparison easier
z = orbits;
for n = 1:nSolutions
  [~, maxIdx] = max(orbits(n,:),[],2);
  z(n,:) = circshift(orbits(n,:), -maxIdx+1,2);
end



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

