function p = orbitSolver(orbit)

  MAX_TRIES = 5000;
  
  for nTry = 1:MAX_TRIES
  
    % Draw a random regularisation
    regLoc = mean(orbit);   % Dirty trick to avoid having the regularisation in the orbit
    regValue = -1 + 2*rand;
    
    % Form the equation matrix
    M = vander([orbit, regLoc]);
    y = [orbit(2:end), orbit(1), regValue].';
    
    % Solve for the polynomial
    x = M \ y;
    p = x.';
    
    % Measure the orbit stability
    dp = polyder(p);
    s = 1;
    for n = 1:length(orbit)
      s = s*polyval(dp, orbit(n));
    end
  
    if (abs(s) < 1.0)
      %fprintf('[INFO] Stable solution found!\n');
      return
    end
  
  end
  
  %fprintf('[WARNING] Could not find a stable solution for the requested orbit.\n')
  p = [];

end
