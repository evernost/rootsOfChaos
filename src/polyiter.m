function q = polyiter(p,n)
  % Generates the n-th iterate of polynomial p

  q = p;
  if (n > 1)
    for iter = 1:(n-1)
      q = polycompose(q,p);
    end
  end
end