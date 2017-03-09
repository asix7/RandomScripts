def find_gcd(a, b):
    mcd = 1
    i = 2
 
    while(i<=a and i<=b):
        if(a%i==0 and b%i==0):
            mcd = i
        i+=1

    return mcd
def better_gcd(a, b):
    while (b != 0):
        t = a
        a = b
        b = t%b
    return a

def main():
    a=2
    b=2
    gcd = better_gcd(a,b)

    n= int(a/gcd)
    d= int(b/gcd)

    if(d== 1):
        print(str(n))
    else:
        print(str(n) + "/" + str(d))

main()
