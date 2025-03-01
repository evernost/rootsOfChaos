function q = polypow(p,n)
  % Raises a polynomial 'p' to the n-th power.

  q = p;
  if (n == 0)
    q = 1;
  elseif (n > 1)
    for m = 1:(n-1)
      q = conv(q,p);
    end
  end
end