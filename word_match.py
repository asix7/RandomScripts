# String matching algorithms
word = "axascass"
pattern = "ssaafasdasdcasaxqwdwdascassaxascassawdqwxascassaxascassaxascassaxascass"

def find_match(word, pattern):
	j = 0;
	if(len(word) > len(pattern)):
		return -1
	for i in range(0, len(pattern)):
		if(word[j] == pattern[i]): 
			j+=1
		else:
			j = 0
		if(j == len(word)):
			return i - len(word) + 1
	return -1

index = find_match(word, pattern)
print(index)

if(index > 0):
	print(pattern[index:index+len(word)])