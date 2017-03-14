import random as rand
import math

def my_gcd(a, b):
    while (b != 0):
        t = a
        a = b
        b = t%b
    return a


def main():
    count = 0
    n = 10000000
    lower_bound = 1
    upper_bound = 100000
    for i in range(0,n):
        a = rand.randint(lower_bound, upper_bound)
        b = rand.randint(lower_bound, upper_bound)
        gcd = my_gcd(a,b)
        if(gcd == 1):
            count += 1

    print(math.sqrt(6/(1.0*count/n)))

main()
