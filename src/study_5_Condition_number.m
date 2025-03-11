% =============================================================================
% Project       : rootsOfChaos
% Module name   : study_5_Condition_number
% File name     : study_5_Condition_number.m
% File type     : Matlab script
% Purpose       : study on the condition number vs the orbit size
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Tuesday, 11 March 2025
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
% CONSTANT
% -----------------------------------------------------------------------------
N_TRIES = 100000;



% -----------------------------------------------------------------------------
% SETTINGS
% -----------------------------------------------------------------------------
gridSize = 100;
g = linspace(-2.0, 2.0, gridSize);


orbitSizeList = 3:23;


% -----------------------------------------------------------------------------
% MAIN LOOP
% -----------------------------------------------------------------------------
c = zeros(N_TRIES, length(orbitSizeList));
for m = 1:length(orbitSizeList)

  for n = 1:N_TRIES
    
    % Draw a random orbit
    orbit = g(randperm(gridSize, orbitSizeList(m)));

    M = vander(orbit);
    c(n,m) = cond(M);


  end

end



% -----------------------------------------------------------------------------
% PLOT RESULTS
% -----------------------------------------------------------------------------
figure
boxplot(log10(c), 'Whisker', Inf)
title('log10(cond)')
grid on
grid minor


vectorNames = cell(1, length(orbitSizeList));
for m = 1:length(orbitSizeList)
  vectorNames{m} = [num2str(orbitSizeList(m))];
end

xticklabels(vectorNames);
xlabel('Orbit size')


figure
stem(log10(min(c,[],1)))
grid minor
