import random

# Create a random list with various options
options = ['A','B','C','D']
list = []
n = 10
for i in range(0,n):
	list.append(options[random.randint(0,len(options) - 1)])
print (list)	

# Booyes-Moore Algorithm Majority Algorithm
def majority(list):
	option = ''
	count = 0
	for e in list:
		if count == 0:
			option = e
			count = 1
		else:
			if option == e:
				count += 1
			else:
				count -= 1
	return option

# Naive Aproach for Test
def naive_majority(list):
	max_count = 0
	majority = ''
	for option in options:
		current = 0
		if option in list:			
			for item in list:
				if option == item:
					current += 1
		if current > max_count:
			majority = option
			max_count = current			
	if max_count > len(list)/2:
		print (majority)
		return majority				

if naive_majority(list)== majority(list):
	print ("True")
else:
	print("False")


