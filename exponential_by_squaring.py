def exponential_by_squaring(x,n):
	if (n < 0):
		return exponential_by_squaring(1.0 / x, -n);
	elif(n == 0):
		return 1
	elif(n == 1):
		return x
	elif(n%2 == 0):
		return exponential_by_squaring(x*x,n/2.0)
	else:
		return x * exponential_by_squaring(x*x,(n-1)/2.0)

 
for i in range(0,101):
	for j in range(0,11):
		print(exponential_by_squaring(i,j))