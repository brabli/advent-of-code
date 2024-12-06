# Psuedo Code
# For each number in numbers,

target = 675280050
numbers = []

with open("Day 9/advent-9-input.txt", "r") as data:
  lines = data.readlines()
  numbers = [int(num[:-1]) for num in lines]

found = False
    
for i in range(0, len(numbers)):
    for j in range(i + 1, len(numbers)):
        contiguous_list = numbers[i:j]
        if max(contiguous_list) >= target:
            break
        total = 0
        for num in contiguous_list:
            total += num
        if (total == target):
            print("Target Hit!")
            minim = min(contiguous_list)
            maxim = max(contiguous_list)
            print("Answer is " + str(minim + maxim))
            found = True
            break
        else:
            total = 0
            if found == True:
                break

