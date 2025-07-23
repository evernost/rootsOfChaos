# rootsOfChaos
A study on polynomial recursions *i.e.* sequences of general term $u_{n}$ such that:

$u_{n+1} = p(u_{n})$

where `p` is a polynomial.<br>

__Question__: how much can we control the behavior of the sequence (single fixed point, 3-cycle, 4-cycle, N-cycle etc.) if `p` is carefully chosen?

Is there a link between the roots of `p` and the way the sequence behaves? 

## The goal
Non-linear recursions can have **periodic** behaviours. 

Usually, they are built with a degree of freedom, a parameter. Changing this parameter will give a different behaviour, eventually another periodic oscillation but with a different cycle length.

However, the cycle length has no reason to change e.g. linearly or even monotonically as the parameter increases. 

Are there parametrised polynomials out there that would provide a 2-cycle, then a 3-cycle, 4-cycle, etc. as the parameter increases?

## The non-linear recursion
Take any number you like, apply any function `f` to it, you get a new number.

With this number, you can repeat the process and apply `f` again.

And again.

And again.

The operation is simple enough, yet it can yield very deep results. Some of which are subject to conjectures that are still unresolved to this day.

Here are a few examples with different functions and different sets of numbers:
- `f` is a **linear function** defined on **real numbers**: either converges unconditionally, diverges, or oscillates between 2 values (see: arithmetico-geometric sequence)
- `f` is a **linear function** defined on **integers**: the behaviour is not always certain (see the Collatz conjecture https://en.wikipedia.org/wiki/Collatz_conjecture)
- `f` is a **linear function** defined on **modular integers (Z/pZ)**: a cool example is the Linear congruential Generator (LCG) which is the integer version of the arithmetico-geometric sequence. Used for pseudo-random number generation, though it needs specific conditions on the coefficients for decent results, and they are far from obvious (https://en.wikipedia.org/wiki/Linear_congruential_generator)
- `f` is a 2nd order polynomial defined on **real numbers**: the logistic map
- `f` is a 2nd order polynomial defined on **complex numbers**: the Mandelbrot set (which has deep connexions with the logistic map)

In this study, I'm mostly interested in the logistic map because it's probably the simplest of all.

Behind its apparent simplicity in the definition, the logistic mapping exhibits very differents behaviours depending on a single parameter (and the initial value to a lesser extent)
- divergence
- convergence to a single value
- periodic oscillations, with various possible cycle length
- erratic, random-like values

In particular, the periodic pattern is quite cool. 

It is pretty easy to observe the period doubling behaviour, which give cycles of period 2, 4, 8, 16, etc. For some other values, periods will be 3, 6, etc.

Then a few questions came to my mind, that I wanted to investigate:
- can I have any period I like? What about 51?
- since the polynomial of the logistic map does not seem to be *that* special, what about other polynomials?
- is there a way to classify all the polynomials with a stable cycle of length `n`? do they have anything remarkable, like a specific locus of their roots?
- is there a *smooth* way to interpolate through the cyclic behaviour? Like a single parameter to go from a 1-cycle, 2-cycle, 3-cycle, etc.? 


## Enforcing a cycle: the brutal approach
Assuming the recursion is done using a polynomial, imposing a cycle can be done by solving the equations:
- f(a) = b
- f(b) = c
- f(c) = d
- f(d) = a
for a 4 steps cycle.

A cycle of length `n` requires `n` equations, so a polynomial of order `n-1` would do. However, there's still the possibility that the cycle is unstable. You might want to either:
- add an extra degree of freedom like f(0) = λ and tune lambda until the cycle is stable (hopefully). This condition is arbitrary (you might as well tweak the derivative on some point etc.), the most important point being that there's a degree of freedom
- tweak the trajectory (i.e. the value of a, b, ...) until it is stable. This approach has more potential that will be explored later on.

It works, but it also give massive polynomials. Let's go for another approach.

## What periods are hidden in second order polynomials?
Let's generate polynomials with random coefficients.

The coefficients are chosen on a grid, so that the possible values taken by the coeffients are less "messy". 

Then, we check whether it contains a defined cycle value. Solutions are stored. 


## Finding the minimal polynomial
As I tried to enforce a cycle brutally, I realised that a basic 2nd order polynomial has all the potential to generate pretty much any cycle length. At least, that is my intuition based on a few empirical observations; nothing rigourous here.

In the first part, I was able to generate any cycle length but that would imply very large polynomials. Meanwhile, a carefully-selected second order polynomial can contain massive cycles. 

The catch in the brutal approach is that it imposes not only the cycle length, but also the cycle itself, which is absolutely overkill. But the degree of freedom is now the orbit of the cycle that I am free to build the way I want.

The order of the polynomial can be huge, but it might be reduced with a carefully-chosen orbit. After all, a 256 cycle of the logistic map may well be a 256-order polynomial, it's just that the trajectory is such that it cancelled most of the terms of the polynomial.

- [ ] If there is a polynomial solving a given orbit, is there a *golden* way to tweak the orbit (even slightly) so that there is still a stable solution, and for which there could even be leading terms in the polynomials that get cancelled?

[TODO]

## *Optimal transport* between polynomials 
For a given cycle length and a given order (usually 2nd order, since it seems to contain every period), there are usually several polynomial solving for it. To answer the initial question, we must now:
- make sure that candidates have a *real* own cycle length (e.g. some 3-cycles have an orbit really close to a 2-cycle)
- find *the proper candidate* for each cycle length
- find *the proper way* to transition from one candidate to the other
- define what we mean by "*the proper*"...

[TODO]

## Link between orbits of different sizes
As the orbit size gets higher in value, it becomes much harder to find a polynomial containing this cycle. 

The coefficients required have very little flexibility and a small deviation can easily demote the solution to a *degenerated* version with a lower cycle length (e.g. in reduction, where coefficients are quantized to 0 when they were not close enough)

But this also shows that some cycles are actually connected. If improper precision can lead to a smaller cycle, a proper tuning could achieve a higher cycle.


[TODO]
 
## Project status
This project does not have any specific goal. I just go with the flow, following what the experiment inspire me.

## TODO
- [ ] Find a *right* way to interpolate between polynomials 
- [ ] Find a *right* way to classify polynomials containing the same cycle length
- [ ] Define a norm to measure distance between orbits, and make sure an orbit of length N doesn't look *to close* from an orbit of shorter length M < N (use circular correlation?)
- [ ] Add a 0-mean constraint to the orbits (or close to) to avoid DC component
- [ ] Add an amplitude constraint to avoid massive jumps when interpolating from one polynomial to the other
- [ ] On the way to stabilisation/reduction, show how the polynomial (and its roots?) evolves
- [ ] Is there a way to derive orbits of size 2N from orbits of size N? They seem 'close' in a polynomial sense
- [ ] Do a similar study with piecewise linear recursions (even simpler!)
- [ ] Find a way to generate bandlimited signal from the periodic patterns of the map

