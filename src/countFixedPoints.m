function n = countFixedPoints(p, order)

  STABLE_ONLY = 0;

  % Build the fixed point polynomial equation
  pf = polyiter(p, order);
  pf(end-1) = pf(end-1) - 1;
  
  % Find roots
  rf = roots(pf);
  
  n = 0;
  for m = 1:length(rf)
    if isreal(rf(m))
      
      if (STABLE_ONLY == 1)
        s = polyval(d_pf, rf(m));
        if (abs(s) < 1)
          n = n + 1;
        end
        
      else
        n = n + 1;
      end
    end
  end
end

