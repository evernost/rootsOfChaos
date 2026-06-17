import numpy as np

def search(
  order         : int,
  length        : int,
  x             : float,
  s             : float,
  coef_bounds   : tuple[float, float] = (-1.0, 1.0),
  wiggle_bounds : tuple[float, float] = (-1.0, 1.0),
  n_iterations  : int = 100,
  seed          : int | None = None,
) -> np.ndarray :
  
  """
  Looks for a polynomial containing a stable orbit of a given length.

  Args:
    order:          Polynomial order
    length:         Length of the orbit
    x:              Start point of the orbit
    s:              Wiggle scale factor
    coef_bounds:    (low, high) for initial coefficient sampling.
    wiggle_bounds:  (low, high) for per-step wiggle sampling.
    n_iterations:   Number of evaluate → wiggle cycles.
    seed:           Optional RNG seed for reproducibility.

  Returns:
    Coefficients of the polynomial (list)
  """
  
  # Initialise the random generator
  rng = np.random.default_rng(seed)

  (low_c, high_c) = coef_bounds
  (low_w, high_w) = wiggle_bounds

  # STEP 1: find a polynomial candidate 
  while True :
    
    # Draw random values for the polynomial's coefficients 
    # Array convention: [a_0, a_1, ..., a_n]
    coeffs = rng.uniform(low_c, high_c, size = order + 1)

    # Iterate the polynomial
    u     = x
    valid = True
    for _ in range(length) :
      u = poly(u, coeffs)

      if (np.abs(u) > 100) :
        valid = False
        break

    if valid :
      err = np.abs(u - x)
      print(f"Potential polynomial found, loop error = {err:.2f}")

      break
    else :
      print(f"Discarding polynomial (P(x) = {u:.2f})")

      

  for i in range(n_iterations) :

    # Wiggle the coefficients
    wiggles = rng.uniform(low_w, high_w, size = order + 1)
    coeffsNew = coeffs + (s * wiggles)

    # Determine the coefficients of P' (for orbit stability assessment)
    coeffsDerivNew  = (np.arange(len(coeffs)) * coeffsNew)[1:]

    # Calculate the orbit
    u = x
    dMin = 100; dMax = -1
    orbit = [float(u)]
    stability = poly(u, coeffsDerivNew)
    for _ in range(length) :
      uNew = poly(u, coeffsNew)
      stability *= poly(u, coeffsDerivNew)

      d = np.abs(uNew-u)

      if (d < dMin) :
        dMin = d

      if (d > dMax) :
        dMax = d

      u = uNew
      orbit.append(float(u))
      
    errNew = np.abs(u - x)

    # Accept/Reject the wiggle applied on the coefficients
    if ((errNew < err) and (dMin > 0.1) and (np.abs(stability) < 1.0)) :
      coeffs  = coeffsNew
      err     = errNew
      print(f"* Attempt #{i}: Loop error = {errNew:0.5f}, Orbit span = [{dMin:0.5f}, {dMax:0.5f}], Stability = {stability}")
      print(f"  orbit = {orbit}")
      print("")
      # print(f"  coeffs = {coeffs}")

  if (err > 0.01) :
    print("Failed to converge.")
  else :
    print("Success!")
  


  return coeffs



def poly(x, coeffs) :
  xPows = x ** np.arange(len(coeffs))
  y = coeffs @ xPows
  return y



if (__name__ == "__main__") :

  L = 3
  x0 = 0.4

  coeffs = search(
    order = 9,
    length = L,
    x = x0,
    s = 0.01,
    coef_bounds = (-5.0, 5.0),
    wiggle_bounds = (-1.0, 1.0),
    n_iterations = 500000,
    seed = 42
  )

  # Stability check (orbit multiple times)
  u = x0
  for _ in range(5) :
    for i in range(L) :
      u = poly(u, coeffs)
      
      if i == (L-1) :
        print(f"{u:0.2f}")
      else :
        print(f"{u:0.2f} -> ", end = "")

    print(f"x = {u}")

