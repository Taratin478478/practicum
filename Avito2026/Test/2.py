r, b = map(int, input().split())
if (r == b):
    print(r + b)
elif (r > b):
    print(2*b + 1)
else:
    print(2*r + 1)
