import random

list = []
n = 100
m = 10000
for i in range(0,n):
	list.append(random.randint(0,m))


def mergesort(list):
	if len(list) < 2:
		return list
	elif len(list) == 2:
		return swap(list[0], list[1])
	else:
		left = mergesort(list[:len(list)/2]) 
		right = mergesort(list[len(list)/2:])
		return merge(left, right)


def swap(first, second):
	if(first > second):
		return [second, first]
	else:
		return [first, second]

def merge(left, right):
	mergedlist = []
	i = 0
	j = 0
	while (i < len(left)) or (j < len(right)):
		if (j >= len(right)):
			mergedlist.append(left[i])
			i+=1
		elif (i >= len(left)):
			mergedlist.append(right[j])
			j+=1
		elif left[i] <= right[j]:
			mergedlist.append(left[i])
			i+=1
		else: 
			mergedlist.append(right[j])
			j+=1
	return mergedlist


def quicksort(list):
	if len(list) < 2:
		return list
	elif len(list) == 2:
		return swap(list[0], list[1])

	pivot = list[random.randint(0, len(list) - 1)]
	left = []
	right = []
	for item in list:
		if(item <= pivot):
			left.append(item)
		else:
			right.append(item)
	left = quicksort(left)
	right = quicksort(right)
	return (left + right)



def bubblesort(list):
	sorted = False
	while not sorted:
		sorted = True
		for i in range(1, len(list) - 1):
			if list[i] < list[i-1]:
				temp = list[i]
				list[i] = list[i-1]
				list[i-1] = temp
				sorted = False
	return list



list = bubblesort(list)	
for i in range(1, len(list) - 1):
	if(list[i-1] > list[i]):
		print ("False")
		break
print (list)
