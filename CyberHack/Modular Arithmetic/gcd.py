a, b = 66528, 52920
if a < b:
    a, b = b, a
while b != 0:
    a, b = b, a % b
print(a)