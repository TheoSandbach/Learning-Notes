a, b = 26513, 32321
if a < b:
    a, b = b, a
a0, b0 = a, b
x0, x1, y0, y1 = 1, 0, 0, 1
while b != 0:
    d = a // b
    a, b = b, a % b
    x0, x1 = x1, x0 - d * x1
    y0, y1 = y1, y0 - d * y1
print(f"{x0} * {a0} + {y0} * {b0} = {a}")