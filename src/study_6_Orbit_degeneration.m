% =============================================================================
% Project       : rootsOfChaos
% Module name   : N/A
% File name     : study_6_Orbit_degeneration.m
% File type     : Matlab script
% Purpose       : study the impact of reducing the orbit length
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Thursday, 20 March 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================

% -----------------------------------------------------------------------------
% DESCRIPTION
% -----------------------------------------------------------------------------
% Find polynomials containing a given orbit size, then merge 2 consecutive 
% points on that orbit and see how that translates in terms of polynomial
% coefficients and roots convergence (if any).

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
% TODO: compare the time plot of different quantizations 