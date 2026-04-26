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

**Fermat's Little Theorem** states that for prime `p`, `a^p = p (mod p)`, or equivalently, `a^(p-1) = 1 (mod p)`.

So for *any* `a`, and *any* prime `p`, we know `a ^ (p-1) = 1`, in `mod p`.

Now, because `Z/pZ` is a field, every integer has a multiplicative inverse: for every `a` in `Z/pZ`, we have some `b` such that `a * b = 1 (mod p)`.

Due to Fermat's Little Theorem, we know that this inverse for any `a` will be `a^(p-2) (mod p)`, as `a * a^(p-2) = a^(p-1) = 1 (mod p)`.

---

### Quadratic Residues

Quadratic and non-quadratic residues deal with the question of square roots in modular arithmetic.

For any `a` in `Z/pZ`, we say `a` is a **Quadratic Residue** if there exists `b` in `Z[p]` such that `b^2 = a (mod p)`, or that `a` is a **Quadratic Non-Residue** if there does not exist such a `b`.

If `b^2 = a (mod p)`, then `(-b)^2 = (p-b)^2 = a (mod p)`, so a quadratic residue has 2 roots, `b` and `p-b`.

---

### Legendre's Symbol


