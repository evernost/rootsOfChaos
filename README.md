# rootsOfChaos
A study on polynomial recursions, the roots of specific polynomials, and their link with chaos in recurrent maps.

# The idea
Take any number you like, apply any function `f` to it, you get a new number.

With this number, you can repeat the process and apply `f` again.

And again.

And again.

The operation is simple enough, yet it can yield very deep results. Some of which are subject to conjectures that are still unresolved to this day.

Here are a few examples with different functions and different sets of numbers:
- `f` is a **linear function** defined on **real numbers**: either converges unconditionally, diverges, or oscillates between 2 values (see: arithmetico-geometric sequence)
- `f` is a **linear function** defined on **integers**: the behaviour is not always certain (see the Collatz conjecture https://en.wikipedia.org/wiki/Collatz_conjecture)
- `f` is a **linear function** defined on **modular integers (Z/pZ)**: a cool example is the Linear congruential Generator (LCG) which is the interger version of the arithmetico-geometric sequence. Used for pseudo-random number generation, though it needs specific conditions on the coefficients for decent results, and they are far from obvious (https://en.wikipedia.org/wiki/Linear_congruential_generator)
- `f` is a 2nd order polynomial defined on **real numbers**: the logistic map
- `f` is a 2nd order polynomial defined on **complex numbers**: the Mandelbrot set (which has deep connexions with the logistic map)

In this study, I'm mostly interested in the logistic map because it's probably the simplest of all.

Behind its apparent simplicity in the definition, the logistic mapping exhibits very differents behaviours depending on a single parameter (and the initial value to a lesser extent)
- divergence
- convergence to a single value
- periodic oscillations, with various possible periods
- erratic, random-like values

In particular, the periodic pattern is quite cool. 

It is pretty easy to observe the period doubling behaviour, which give cycles of period 2, 4, 8, 16, etc. For some other values, periods will be 3, 6, etc.

Then a few questions came to my mind, that I wanted to investigate:
- can I have have any period I like? What about 51?
- since the polynomial of the logistic map does not seem to be *that* special, what about other polynomials?
- is there a way to classify all the polynomials with a stable cycle of length `n`? do they have anything remarkable, like a specific locus of their roots?
- is there a *smooth* way to interpolate through the cyclic behaviour? Like a single parameter to go from a 1-cycle, 2-cycle, 3-cycle, etc.? 


# First approach: the brutal approach
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

# Second approach: the polynomial sieve
Let's generate polynomials with random coefficients.

The coefficients are chosen on a grid to be less messy. 

Then, we check whether it contains a defined cycle value.



# Third approach: finding the minimal polynomial
The second approach made me realise that a basic 2nd order polynomial has all the potential to generate pretty much any cycle length. At least, that is my intuition based on a few empirical observations; nothing rigourous here.

In the first part, I was able to generate any cycle length but that would imply very large polynomials. Meanwhile, a carefully-selected second order polynomial can contain massive cycles. 

The catch in the brutal approach is that it imposes not only the cycle length, but also the cycle itself, which is absolutely overkill. But the degree of freedom is now the orbit of the cycle that I am free to build the way I want.

The order of the polynomial can be huge, but it might be reduced with a carefully-chosen orbit. After all, a 256 cycle of the logistic map may well be a 256-order polynomial, but the trajectory is such that it killed the terms of the polynomial all the way to the second!
 
# Project status
This project does not have any specific goal. I just go with the flow, following what the experiment inspire me.

# TODO
- [ ] Do a similar study with piecewise linear recursions (even simpler!)



