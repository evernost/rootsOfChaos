% =============================================================================
% Project       : rootsOfChaos
% Module name   : fixedPointAnalysis
% File name     : fixedPointAnalysis.m
% Purpose       : TODO
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

function [z, zDeriv, zInd, nFix] = fixedPointAnalysis(p, x, y)
  dp = polyder(p);
  eq = y - x;

  signChange = find(eq(1:end-1) .* eq(2:end) < 0);
  if ~isempty(signChange)    
    nZeros = length(signChange);
    z = zeros(nZeros, 1);
    zDeriv = zeros(nZeros, 1);
    zInd = zeros(nZeros, 1);
    nFix = nZeros;
    for n = 1:nZeros
      z(n) = x(signChange(n));
      zDeriv(n) = polyval(dp, x(signChange(n)));
      zInd(n) = signChange(n);
    end
  else
    z = [];
    zDeriv = [];
    zInd = [];
    nFix = 0;
  end
end

