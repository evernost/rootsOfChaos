import numpy as np

def search(
  order         : int,
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

  # Draw random coefficients [a_0, a_1, ..., a_n]
  coeffs = rng.uniform(low_c, high_c, size = order + 1)

  # Pre-compute powers of x once: [x^0, x^1, ..., x^n]
  xPows = x ** np.arange(order + 1)

  # Evaluate |P(x)-x|
  d = np.abs((coeffs @ xPows) - x)

  for i in range(n_iterations) :

    # Choose a wiggle
    wiggles = rng.uniform(low_w, high_w, size = order + 1)
    coeffsNew = coeffs + (s * wiggles)

    dNew = np.abs((coeffsNew @ xPows) - x)

    if (dNew < d) :
      coeffs = coeffsNew
      d = dNew
      print(f"New solution: d = {dNew}")


  return coeffs


if __name__ == "__main__" :
  vals = search(
    order = 3,
    x = -0.2,
    s = 0.1,
    coef_bounds = (-1.0, 1.0),
    wiggle_bounds = (-1.0, 1.0),
    n_iterations = 1000,
    seed = 42,
  )
