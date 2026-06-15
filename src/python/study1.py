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
  Repeatedly evaluates a wiggled polynomial at x.

  Args:
    order:          Polynomial order
    length:         Length of the orbit
    x:              Evaluation point
    s:              Wiggle scale factor
    coef_bounds:    (low, high) for initial coefficient sampling.
    wiggle_bounds:  (low, high) for per-step wiggle sampling.
    n_iterations:   Number of evaluate → wiggle cycles.
    seed:           Optional RNG seed for reproducibility.

  Returns:
    Array of shape (n_iterations,) with P(x) at each step.
  """

  rng = np.random.default_rng(seed)
  (low_c, high_c) = coef_bounds
  (low_w, high_w) = wiggle_bounds

  # Draw random values for the polynomial's coefficients 
  # Array convention: [a_0, a_1, ..., a_n]
  coeffs = rng.uniform(low_c, high_c, size = order + 1)

  u = x
  for _ in range(length) :
    u = P(u, coeffs)
  err = np.abs(u - x)

  for i in range(n_iterations) :

    # Wiggle the coefficients
    wiggles = rng.uniform(low_w, high_w, size = order + 1)
    coeffsNew = coeffs + (s * wiggles)

    # Determine the coefficients of P' (for orbit stability assessment)
    coeffsDeriv  = (np.arange(len(coeffs)) * coeffsNew)[1:]

    u = x
    dMin = 100; dMax = -1
    orbit = [float(u)]
    stability = 1
    for _ in range(length) :
      uNew = P(u, coeffsNew)

      d = np.abs(uNew-u)

      if (d < dMin) :
        dMin = d

      if (d > dMax) :
        dMax = d

      u = uNew
      orbit.append(float(u))
      
    errNew = np.abs(u - x)

    if ((errNew < err) and (dMin > 0.2)) :
      coeffs  = coeffsNew
      err     = errNew
      print(f"* Attempt #{i}: Loop error = {errNew:0.5f}, orbit distance = [{dMin:0.5f}, {dMax:0.5f}]")
      print(f"  orbit = {orbit}")
      print("")
      # print(f"  coeffs = {coeffs}")

  if (err > 0.01) :
    print("Failed to converge.")
  else :
    print("Success!")
  
  # print(f"Seed used = {rng.bit_generator.state['state']['state']}")

  return coeffs



def P(x, coeffs) :
  xPows = x ** np.arange(len(coeffs))
  y = coeffs @ xPows
  return y



if __name__ == "__main__" :

  L = 3
  x0 = 0.1

  coeffs = search(
    order = 5,
    length = L,
    x = x0,
    s = 0.03,
    coef_bounds = (-3.0, 3.0),
    wiggle_bounds = (-1.0, 1.0),
    n_iterations = 200000,
    seed = 41
  )

  # Stability check (orbit multiple times)
  u = x0
  for _ in range(3) :
    for _ in range(L) :
      u = P(u, coeffs)

    print(f"x = {u}")

