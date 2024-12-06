adapters = []

# Parse input to list of ints
with open("Day 10/advent-10-input.txt", "r") as data:
    lines = data.readlines()
    numbers = [int(number[:-1]) for number in lines]
    numbers.append(0)
    numbers.append(max(numbers) + 3)
    numbers.sort()
    adapters = numbers

def get_differences(adapters):
    diff_of_one = 0
    diff_of_two = 0
    diff_of_three = 0
    for i in range(0, len(adapters) - 1):
        if adapters[i] + 1 == adapters[i + 1]:
            diff_of_one += 1
        elif adapters[i] + 2 == adapters[i + 1]:
            diff_of_two += 1
        elif adapters[i] + 3 == adapters[i + 1]:
            diff_of_three += 1
        else:
            print("It broke lol")
            print(f"Multiplied together: {diff_of_one * diff_of_three}")

get_differences(adapters)