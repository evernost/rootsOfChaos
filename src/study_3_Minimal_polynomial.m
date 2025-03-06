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
orbitSize = 7;

gridSize = 50000;
g = linspace(-1.0, 1.0, gridSize);


% -----------------------------------------------------------------------------
% FIRST APPROACH: RANDOM
% -----------------------------------------------------------------------------
nSol = 0;
while (nSol < nTarget)
  
  % Draw a random orbit (+ 1 extra control point to tune the stability)
  u = g(randperm(gridSize, orbitSize + 1));
  
  % Draw a random regularisation
  lambda = 0.9*(-1 + 2*rand);
  
  M = vander(u);
  x = [u(2:(end-1)), u(1), lambda].';
  
  v = M \ x;
  
  if (abs(v(1)) < 0.01) && (abs(v(2)) < 0.1)
    disp('Found!')
    p = v.';
    nSol = nSol + 1;
  end
  
end
  
  
  
