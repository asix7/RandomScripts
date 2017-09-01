import sys

def main(n):
	count = 0
	while(n != 1):
		if(n%2 == 0):
			n=n/2
		else:
			n=3*n+1
		count+=1
	return count

max = 0
for i in range(1,90000000):
	count = main(i)
	if(count > max):
		print(str(i) + " / " + str(count))		
		max = count



