#!/usr/bin/env python3
def main (path: str):


def parse(path: str) -> tuple:
    # Open the file containing the input data
    with open(path, "r") as input_file:
        # Loop through each line of the file (line is a string)
        for (snack, numbered_line) in enumerate(input_file):
            # Strip the last character (a newline) from the line
            if line[-1] == "\n":
                elf = elf + 1
                line = line[:-1]

            if line == "\n" or line == "":
                continue

            # If we've reached a line that indicates we need to switch what we're parsing,
            # update the running "currently_parsing" enum to reflect that, and then continue to the next line
            if line == "Game slots:" \
    with open("d1-input.txt", "r") as f:
        # Read the contents of the file into a list of strings, one string per line
        data = f.readlines()

    # Remove the newline characters from each string in the list
    #data = [x.strip() for x in data]

    # Convert the strings containing numbers to integers
    if x.isdigit():
    data = [int(x) for x in data if x.isdigit()]

    print(data)
    # Read the input data
    #data = [1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]

    # Initialize an empty dictionary to keep track of the Calories carried by each Elf
    calories = {}

    # Iterate over the input data
    for calorie in data:
        # If the current calorie is the first item for a new Elf, initialize their total Calories to 0
        if calorie not in calories:
            calories[calorie] = 0

        # Add the current calorie to the total Calories for the current Elf
        calories[calorie] += calorie

    # Find the Elf with the most Calories
    max_calories = 0
    max_elf = None
    for elf, calorie in calories.items():
        if calorie > max_calories:
            max_calories = calorie
            max_elf = elf

    # Output the number of Calories carried by the Elf with the most Calories
    print(max_calories)




if __name__ == "__main__":
    main()
