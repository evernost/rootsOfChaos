% =============================================================================
% Project       : rootsAndChaos
% Module name   : study_2_Roots_and_orbits
% File name     : study_2_Roots_and_orbits.m
% File type     : Matlab script
% Purpose       : 
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Saturday, 01 March 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================

% -----------------------------------------------------------------------------
% DESCRIPTION
% -----------------------------------------------------------------------------
% TODO


% Plusieurs questions : 
% - si des choses se passe dans un coin très particulier, comment
% cibler ma génération de polynômes pour que ça tombe spécifiquement
% dans cette zone ?
% - un clic sur un pôle montre le polynôme associé et quelques itérations
% de la suite récurrente
% - générer ça dans un fichier image plutôt qu'un vieux plot
% - par quel miracle un polynome d'ordre 2 peut avoir des périodes d'ordre
% 4, 8, 16, ou même 3 ???


close all
clear all
clc



% -----------------------------------------------------------------------------
% SETTINGS
% -----------------------------------------------------------------------------
order = 4;
maxPeriod = 4;
nRuns = 500000;

gridSize = 45;
gridMin = -2.0;
gridMax = 2.0;



% -----------------------------------------------------------------------------
% STEP 1: GENERATE A COLLECTION OF POLYNOMIALS
% -----------------------------------------------------------------------------
r = zeros(nRuns, order);
g = linspace(gridMin, gridMax, gridSize);
period = zeros(nRuns,1);
for n = 1:nRuns
  
  % Draw a period constraint (1 = simple fixed points, 2 = 2 points
  % orbit, etc.)
  period(n) = randi([1, maxPeriod]);
  
  while 1
    valid = 1;
    
    % Draw control points
    % A n-th order polynomials must constrained at n+1 values.
    % All values must be different
    v = g(randperm(gridSize, order+1)).';
    M = vander(v);
    
    % Draw a constraint value on the control points
    % For a period 'm', there are order+1-m values that need to be
    % constrained.
    lambda = gridMin + (gridMax-gridMin)*rand(order+1-period(n), 1);
    y = [v(2:period(n)); v(1); lambda];

    % Solve the polynomial
    p = M \ y;
    rTmp = roots(p);
    
    % INVALID CASE 1: leading coefficient is too small
    if (abs(p(1)) < 0.001)
      valid = 0;
    end
    
    % INVALID CASE 2: multiple roots
    if (length(rTmp) < order)
      valid = 0;
      fprintf('[INFO] Skipping multiple root\n');
    end
    
    d_p = polyder(p);
    s = 1;
    for k = 1:period(n)
      s = s*polyval(d_p, v(k));
    end

    % INVALID CASE 3: orbit is not stable
    if (abs(s) > 1)
      valid = 0;
      %fprintf('[INFO] Skipping unstable orbit\n');
    end

    % VALID ROOT: store it
    if (valid == 1)
      r(n,:) = rTmp;
      break
    end
  end
end



% -----------------------------------------------------------------------------
% STEP 2: RE-ARRANGE DATASET
% -----------------------------------------------------------------------------
% Column 1: root value
% Column 2: polynomial index
% Column 3: period
% Column 4 to 6: color
rootLocus = zeros(order*nRuns, 1+1+1+3);
cMap = hsv(maxPeriod);
for n = 1:nRuns
  for m = 1:order
    rootLocus(m + order*(n-1), 1) = r(n, m);
    rootLocus(m + order*(n-1), 2) = n;
    rootLocus(m + order*(n-1), 3) = period(n);
    rootLocus(m + order*(n-1), 4:6) = cMap(period(n), :);
  end
end


% -----------------------------------------------------------------------------
% STEP 3: PLOT RESULTS
% -----------------------------------------------------------------------------

scatter(real(rootLocus(:,1)), imag(rootLocus(:,1)), [], rootLocus(:,4:6), '.')
xlim([-4 4])
ylim([-2 2])
grid minor

