# Modular Arithmetic

---

### Greatest Common Divisor

GCD = largest integer that divides both of two positive integers `a` and `b`.

'Coprime' integers `a` and `b` have GCD = 1

`a` & `b` prime => `a`, `b` coprime

`a` prime, & `b` < `a` => `a`, `b` coprime

Euclid's Algorithm: For any positive integers `a` > `b`, we have `gcd(a,b) = gcd(b,c)` for `c = a mod b`

We calculate `a mod b`, and then repeat this process with `(a,b) = (b, a mod b)` until `b = 0`. Then `a` is the GCD of our original two numbers.

---

### Extended GCD

The Extended Euclid's Algorithm gives us an efficient way to calculate Bezout's identity:

`x * a + y * b = gcd(a,b) for some integers x, y`

We get `x, y` by finding gcd(a,b) with Euclid's algorithm and then climb back up our working, subsituting in `a` and `b` as we do to end up with a linear combination for `gcd(a,b)` in terms of `a`, `b`, `x`, and `y`.

For each remainder we find by working through the Euclidean Algorithm, `r[i]`, we have `r[i] = x[i] * a + y[i] * b` for some `x[i]` and `y[i]`.

`a = q[i] * b + r[i]` for some `q[i]`, so `r[i] = a - q[i] * b`, then `r[i+1] = b - q[i+1] * r[i]` for some `q[i+1]`, and `r[i+2] = r[i] - q[i+2] * r[i+1]`, and so on.

So let `r[0] = a = 1 * a + 0 * b`, and `r[1] = b = 0 * a + 1 * b`. As `r[i] = x[i] * a + y[i] * b`, we have `x[0] = 1`, `x[1] = 0`, `y[0] = 0`, and `y[1] = 1`.








