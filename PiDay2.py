import math
def main():
    n = 100000000
    sum = 0
    for i in range(1,n):
        sum += 1.0/(i*i)
    print (math.sqrt(6*sum))

main()