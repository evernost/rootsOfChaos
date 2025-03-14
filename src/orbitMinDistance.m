% =============================================================================
% Project       : rootsOfChaos
% Module name   : orbitMinDistance
% File name     : orbitMinDistance.m
% Purpose       : measure orbit degeneration
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Wednesday, 12 March 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================
%
% DESCRIPTION
% Measures the minimal distance between any 2 points in the orbit.
% This can be used to estimate if an orbit is degenerate or not.
% 
% Arguments:
% TODO
%
% Outputs:
% TODO
%

function d = orbitMinDistance(orbit)
  
  dSort = sort(diff(sort(orbit,2)),2);
  d = dSort(1);

end
