# Modular Arithmetic

---

### Greatest Common Divisor

GCD = largest integer that divides both of two positive integers `a` and `b`.

'Coprime' integers `a` and `b` have GCD = 1

`a` & `b` prime => `a`, `b` coprime

`a` prime, & `b` < `a` => `a`, `b` coprime

**Euclid's Algorithm**: For any positive integers `a` > `b`, we have `gcd(a,b) = gcd(b,c)` for `c = a mod b`

We calculate `a mod b`, and then repeat this process with `(a,b) = (b, a mod b)` until `b = 0`. Then `a` is the GCD of our original two numbers.

---

### Extended GCD

The Extended Euclid's Algorithm gives us an efficient way to calculate **Bezout's identity**:

`x * a + y * b = gcd(a,b) for some integers x, y`

We get `x, y` by finding gcd(a,b) with Euclid's algorithm and then climb back up our working, subsituting in `a` and `b` as we do to end up with a linear combination for `gcd(a,b)` in terms of `a`, `b`, `x`, and `y`.

For each remainder we find by working through the Euclidean Algorithm, `r[i]`, we have `r[i] = x[i] * a + y[i] * b` for some `x[i]` and `y[i]`.

`a = q[i] * b + r[i]` for some `q[i]`, so `r[i] = a - q[i] * b`, then `r[i+1] = b - q[i+1] * r[i]` for some `q[i+1]`, and `r[i+2] = r[i] - q[i+2] * r[i+1]`, and so on.

So let `r[0] = a = 1 * a + 0 * b`, and `r[1] = b = 0 * a + 1 * b`. As `r[i] = x[i] * a + y[i] * b`, we have `x[0] = 1`, `x[1] = 0`, `y[0] = 0`, and `y[1] = 1`.

---

### Fermat's Little Theorem and Multiplicative Inverses

If `p` is prime, then `Z/pZ` (All integers `mod p`) is a field (addition and multiplication, communicative and associative, all elements have additive and multiplicative inverses).

If `p` is not prime, then `Z/pZ` instead is a ring: not every element has a multiplicative inverse (but every element has an additive inverse).

**Fermat's Little Theorem** states that for prime `p` and `a` not a multiple of `p`, `a^p = a (mod p)`, or equivalently, `a^(p-1) = 1 (mod p)`.

So for *any* `a =/= np`, and *any* prime `p`, we know `a ^ (p-1) = 1`, in `mod p`.

Now, because `Z/pZ` is a field, every integer has a multiplicative inverse: for every `a` in `Z/pZ`, we have some `b` such that `a * b = 1 (mod p)`.

Due to Fermat's Little Theorem, we know that this inverse for any `a` will be `a^(p-2) (mod p)`, as `a * a^(p-2) = a^(p-1) = 1 (mod p)`.

---

### Quadratic Residues

Quadratic and non-quadratic residues deal with the question of square roots in modular arithmetic.

For any `a` in `Z/pZ`, we say `a` is a **Quadratic Residue** if there exists `b` in `Z[p]` such that `b^2 = a (mod p)`, or that `a` is a **Quadratic Non-Residue** if there does not exist such a `b`.

If `b^2 = a (mod p)`, then `(-b)^2 = (p-b)^2 = a (mod p)`, so a quadratic residue has 2 roots, `b` and `p-b`.

---

### Euler's Criterion and Legendre's Symbol

**Euler's Criterion** tells us that we can calculate `a^((p-1)/2) (mod p)` to determine whether `a` is a quadratic residue or not. 

The result of this exponential is either `-1`, `1`, or `0`:

- `a^((p-1)/2) = 1 (mod p)` means `a` is quadratic residue `mod p`

- `a^((p-1)/2) = -1 (mod p)` means `a` is quadratic non-residue `mod p`

- `a^((p-1)/2) = 0 (mod p)` simply means `a` is a multiple of `p`

We also know that `a^((p-1)/2) * b^((p-1)/2) (mod p) = (ab)^((p-1)/2) (mod p)`, so quadratic residues and quadratic non residues multiply with themselves to give quadratic residues and with each other to give quadratic non-residues.

**Legendre's Symbol** is simply a shorthand representation of this exponential as a function of `a` and `p`: `(a/p) = a^((p-1)/2) (mod p)`.

So we can use Euler's Criteron to find out if a given `a` is a quadratic residue for a prime `p` by seeing if the result of this exponential is 1 or not.

When we know some `a` is a quadratic residue, we may have to find its roots. This is simple if `p = 3 (mod 4)` as we have:

`a ^ (1/2) = (a * 1) ^ (1/2) = (a * a ^ ((p-1)/2)) ^ (1/2) = (a ^ ((p+1)/2) ^ 1/2 = a ^ ((p+1)/4)` 

and as `p = 3 (mod 4)`, then `p+1 = 0 (mod 4)`, so `(p+1)/4` is an integer.

So one root is simply given by `a ^ ((p+1)/4)`, and the other is simply `p` minus the first root.

Finding the root of `a` when `p = 1 (mod 4)` is not quite as straighforward, specifically in the case where `p = 1 (mod 8)`, but there are more complex methods to do such.

---

### Modular Square Roots and Tonelli-Shanks

If we instead have `p = 1 (mod 4)`, then we either have `p = 1 (mod 8)` or `p = 5 (mod 8)`. In the second case, we can use a relatively simple method:

`a` is a quadratic residue `mod p`, so we have `a ^ ((p-1)/2) = 1 (mod p)`. As such, `a ^ ((p-1)/4) (mod p)` is either `1` or `-1`.

We have `a * a ^ ((p-1)/4) = a ^ ((p+3)/4) = (a ^ ((p+3)/8)) ^ 2 (mod p)`.

Now as `p = 5 (mod 8)` we know `(p+3)/8` is an integer, as `p+3 = 0 (mod 8)`. So if `a ^ ((p-1)/4) = 1 (mod p)` we have `(a ^ ((p+3)/8)) ^ 2 = a (mod p)`, and we are done - the root is simply `a ^ ((p+3)/8) (mod p)`.

However, if instead we have `a ^ ((p-1)/4) = -1 (mod p)`, then this doesn't work - we cannot have `(a ^ ((p+3)/8)) ^ 2 = -a (mod p)`. 

So what we need is some `b` such that `b^2 = -1 (mod p)`, and then we have `(a ^ ((p+3)/8)) ^ 2 * b ^ 2 = (b * a ^ ((p+3)/8)) ^ 2 = -1 * -a = a (mod p)`, so our root is `b * a ^ ((p+3)/8) (mod p)`.

Due to a fact called *quadratic reciprocity* (beyond the scope of these notes) we know that for all primes `p` with `p = 5 (mod 8)`, `2` must be a quadratic non-residue. So for all such `p`, `(2/p) = -1`. This means we know `2 ^ ((p-1)/2) = -1 (mod p)`, so we have `(2 ^ ((p-1)/4)) ^ 2 = -1 (mod p)`, which is exactly what we need. So when we have `a ^ ((p-1)/4) = -1 (mod p)`, our root is `2 ^ ((p-1)/4) * a ^ ((p+3)/8) (mod p)`, and we are done.

...

Now the final case: If we have `p = 1 (mod 8)`, then we must use a more complex method called **Tonelli-Shanks**. 

*Note: This method works for all cases of `p` odd prime and `a` not a multiple of `p` (or `0`), but is beaten by faster methods in the other cases.*

This method works by finding an initial estimate `x` for the square root of `a`, and then narrowing the error margin each algorithm cycle until we find the correct value for `x`. The error is labelled `t`, and we have `x^2 = a*t`. The error `t` is built such that repeated squaring will loop it back to `1 (mod p)`. We shrink `t` by tracking how many times it needs squaring before it loops back, and then modifying `t` so that this number decreases on the next cycle, until we have reduced the number of squarings needed to `0` so we have `t = 1`. At each cycle we adjust `x` to maintain `x^2 = a*t`, so that we achieve `x^2 = a` when `t = 1`. 

To do these adjustments we find a quadratic non-residue value `c` and manipulate it with specific exponents such that our new `c` matches the same squaring pattern as `t`: it reaches `1 (mod p)` after the same number of squarings. Crucially, this means with one less squaring, `t` and `c` both are `-1` (as `-1 ^ 2 = 1`), so their product is `1` for one less squaring than each of them individually. We can use this fact to modify `t` using `c` to reduce the number of squarings needed, and then we modify `x` accordingly to maintain its relationship with `t`.

As stated, this method works for any odd prime `p` and `a =/= 0 (mod p)`, but for the above mentioned cases, other methods may be faster. 

---

### The Chinese Remainder Theorem

The **Chinese Remainder Theorem** says that if we have some `x` that satisfies:

- `x = a1 (mod p1)`

- `x = a2 (mod p2)`

- ...

- `x = an (mod pn)` 

Then we have a *unique* `x` solution to `x = a (mod P)` where `P = p1 * p2 * ... * pn`. That is, there is only 1 `x` value `mod P` that satisfies all of these equations.

To determine the value of `a`, we must consider the fact that we want a value `a` for which `a = a1 (mod p1)`, `a = a2 (mod p2)`, and so on.

To solve the first equation, we need `a` to take the form `a1 + p1 * k`. But then we need `a = a2 (mod p2)` to solve the second equation as well. The `a1` term of `a` must disappear given we cannot assume `a1 = a2`, so we must alter our `a` term to be `b1 * p2 + b2 * p1 + k * p1 * p2`, where `b1 * p2 = a1 (mod p1)` and `b2 * p1 = a2 (mod p2)` for some `b1` and `b2`. This means `a` is `a1` for `mod p1` and `a2` for `mod p2` as required. 

To find `b1`, we first find the inverse of `p2` in `mod p1` using the *Extended Euclidean Algorithm*, so we have `p2^(-1) * p2 = 1 (mod p1)`. We then multiply this by  `a1` to give `p2^(-1) * a1 * p2 = a1 (mod p1)`, so we have `b1 = p2^(-1) * a1`, which gives `b1 * p2 = a1 (mod p1)`. We do similar to find `b2` using the inverse of `p1`, giving `b2 = p1^(-1) * a2`.

But then we need to alter `a` to satisfy `a = a3 (mod p3)` as well. So we alter `a` to be `(p2^(-1) * p3^(-1) * a1) * p2 * p3 + (p1^(-1) * p3^(-1) * a2) * p1 * p3 + a3 * p1 * p2 + k * p1 * p2 * p3`, and so on.

We end up with an `a` term of the form `c1 * P / p1 + c2 * P / p2 + ... + cn * P / pn + k * P` where `c1 = P*(-1) / p1^(-1)`, `c2 = P*(-1) / p2^(-1)`, ... , `cn = P*(-1) / pn^(-1)`. This `a` term reduces to `a1` for `mod p1`, `a2` for `mod p2`, and so on. In `mod P`, we simply lose the `k * P` term, giving `a = c1 * P / p1 + c2 * P / p2 + ... + cn * P / pn`.

# ^^^ Make this more intuitive

---
