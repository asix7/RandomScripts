# Author: Andres Landeta 2016
# Practice random shuffles, and see their effectiveness

import random
import math
list = ["Hola", "no", "estoy", "aqui", "Javi", "assca"]

# Inplace shuffle
def shuffle(list):
	for index in range(0, len(list)):
		new_index = random.randint(0, len(list) - 1)
		var = list[index]
		list[index] = list[new_index]
		list[new_index] = var
	return list

# Stract form list shuffle
def shuffle2(list):
	new_list = []
	while len(list) > 0:
		index = random.randint(0, len(list) - 1)
		new_list.append(list[index])
		list.pop(index)
	list = new_list
	return list

# Count ocurrance of each combination
dic = {}
n = 10000
for i in range(0,n):
	list = shuffle(list)
	
	if str(list) in dic.keys():
		dic[str(list)] += 1
	else:
		dic[str(list)] = 1	 

# Calculate the mean
sum = 0
for combination in dic.keys():
	sum += dic[combination]
	print (dic[combination]) 
mean = 1.0*sum/len(dic.keys())

print ("Mean:")
print (mean)

# Calculate Standard deviation
coeficient = 0
for combination in dic.keys():
	coeficient += (mean - dic[combination]) * (mean - dic[combination]) 
standard_deviation = math.sqrt(coeficient/n)
print (standard_deviation)


