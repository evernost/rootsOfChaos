function [z, zDeriv] = fixedPointAnalysis(p, x, y)
  dp = polyder(p);
  eq = y - x;

  if (eq(1)*eq(end) < 0)
    signChange = find(eq(1:end-1) .* eq(2:end) < 0);
    if ~isempty(signChange)
      
      nZeros = length(signChange);
      z = zeros(nZeros, 1);
      zDeriv = zeros(nZeros, 1);
      for n = 1:nZeros
        x( = x(signChange(k));

        % The m-th iterate (m < orbitSize) can have a fixed point, but it
        % must not be stable.
        % If it is: discard the polynomial.
        if (abs(polyval(dp,x0)) < 1.0)
          found = -1;
          break;
        end
      end
    end
  else
    z = [];
    zDeriv = [];
  end
    
    
end

