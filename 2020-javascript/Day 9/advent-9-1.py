numbers = []
with open("Day 9/advent-9-input.txt", "r") as data:
  lines = data.readlines()
  numbers = [int(num.rstrip("\n")) for num in lines]

preamble = numbers[0:25]
numbers = numbers[25:]
target = numbers[0]

def brute_forcer(preamble, target):
  found = False
  for i in range(0, 25):
    num1 = preamble[i];
    for j in range(0, 25):
      if i == j:
        continue
      num2 = preamble[j]
      if num1 + num2 == target:
        found = True
        break
    if found:
      return True
  if found == False:
    print(target)
    return False

while brute_forcer(preamble, target):
  preamble.pop(0)
  preamble.append(target)
  numbers.pop(0)
  target = numbers[0]
  if target is None:
    print("Null target!")
    break