function r = polycompose(p,q)
  % Composes polynomial p with polynomial q 
  % i.e. returns p(q(x))
  

  m = length(p)-1;
  n = length(q)-1;
  
  out = zeros(m+1, m*n+1);
  
  for k = 1:(m+1)
    
    % Raise q(x) to the power m-(k-1)
    tmp = p(k)*polypow(q, m-(k-1));
    d = n*(m-(k-1));
    
    out(k, (m*n - d + 1):end) = tmp;
  end
    
  r = sum(out,1);

end