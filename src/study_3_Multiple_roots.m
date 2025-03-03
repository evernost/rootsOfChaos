% =============================================================================
% Project       : rootsAndChaos
% Module name   : study_3_Multiple_roots
% File name     : study_3_Multiple_roots.m
% File type     : Matlab script
% Purpose       : 
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Sunday, 02 March 2025
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

nRuns = 10000000;
order = 2;

for n = 1:nRuns
  p = -1.0 + 2.0*rand(1,3);
  
  found = 0;
  x = linspace(-1,1,1000);
  y = x;
  for m = 1:order
    y = polyval(p,y);
    
    z = y-x;
    
    if (m < order)
      if (all(z > 0) || all(z < 0))
        found = 0;
      else
        break;
      end
    else
      if (all(z > 0) || all(z < 0))
        %plot(z)
        %grid minor
        found = 0;
      else
        found = 1;
      end
    end
  end
  
  if (found == 1)
    x = linspace(-1.0, 1.0, 1000);
    y = x;
    for m = 1:order
      y = polyval(p,y);
      plot(x',y',x',x')
      title(num2str(m))
      ylim([-1 1])
      grid minor
    end
    plot(x',y',x',x')
    grid minor
    ylim([-1 1])
    disp('found')

  end
end
