# -*- coding: utf-8 -*-
"""
This script has various code evaluations for LLM training at ScaleAI/Outlier.
The script consists of small code snippets from various easy to medium prompts

@author: alima
"""

import datetime

#################################################################
## Minimum amount of a restricted selection of numbers, tokens ##
#################################################################

def min_tokens_for_sum(n):
    """
    Calculate the minimum amount of tokens necessary to sum to a given number.

    Args:
    n (int): The target sum.

    Returns:
    int: The minimum number of tokens required to reach the target sum.
    """
    tokens = [1, 7, 9, 13, 25, 30]

    # Initialize a list to store the minimum number of tokens for each sum from 0 to n
    subarr = [float('inf')] * (n + 1)
    subarr[0] = 0  # Base case: 0 tokens are needed to sum to 0

    for i in range(1, n + 1):
        for token in tokens:
            # If the current token is less than or equal to the current sum
            if token <= i:
                # Update the minimum number of tokens for the current sum
                subarr[i] = min(subarr[i], subarr[i - token] + 1)

    return subarr[n]

# Test cases
print(min_tokens_for_sum(10))  # Output: 2 (7 + 3, but 3 is not in tokens, so 1 + 9)
print(min_tokens_for_sum(25))  # Output: 1 (25 is in tokens)
print(min_tokens_for_sum(30))  # Output: 1 (30 is in tokens)
print(min_tokens_for_sum(100))  # Output: 4 (25 + 25 + 25 + 25)



#########################
## NBA API DATA READER ##
#########################


from nba_api.stats.static import players
import pandas as pd

# Retrieve all players
player_dict = players.get_players()

# Convert to DataFrame
df = pd.DataFrame(player_dict)

# Display the first 10 players
print(df.head(10))



#########################################
## Filtering odd nubers and summing up ##
#########################################

def filter_odd_and_sum(numbers):
    """
    Filters out and prints the odd numbers from a given list of numbers,
    displays the remaining numbers and the sum of the remaining numbers.

    Args:
        numbers (list): A list of integers.

    Raises:
        TypeError: If the input is not a list.
        ValueError: If the list contains non-integer values.
    """

    # Check if input is a list
    if not isinstance(numbers, list):
        raise TypeError("Input must be a list.")

    # Check if all elements in the list are integers
    if not all(isinstance(num, int) for num in numbers):
        raise ValueError("List must contain only integers.")

    # Filter out odd numbers
    even_numbers = [num for num in numbers if num % 2 == 0]
    odd_numbers = [num for num in numbers if num % 2!= 0]

    # Calculate the sum of even numbers
    try:
        sum_even_numbers = sum(even_numbers)
    except OverflowError:
        print("The sum of the remaining numbers is too large to be calculated.")
        return

    # Print the results
    print("Odd numbers:", odd_numbers)
    print("Remaining numbers after filtering out odd numbers:", even_numbers)
    print("Sum of the remaining numbers:", sum_even_numbers)


# Example usage
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
filter_odd_and_sum(numbers)

# Test with invalid input
try:
    filter_odd_and_sum("not a list")
except TypeError as e:
    print(e)

try:
    filter_odd_and_sum([1, 2, "three", 4, 5])
except ValueError as e:
    print(e)



###########################
## Next weekday printing ##
###########################

def weekday():
    today = datetime.date.today()
    for i in range(10):
        current_date = today + datetime.timedelta(days=i)
        if current_date.weekday() < 5:  # Monday is 0, Friday is 4
            print(f"{current_date.strftime('%A')}, {current_date}")

weekday()


###############################
## Khayyam/Pascal's Triangle ##
###############################

def getRow(rowIndex):
        res = [1]
        prev = 1
        for k in range(1, rowIndex + 1):
            next_val = prev * (rowIndex - k + 1) // k
            res.append(next_val)
            prev = next_val
            
        return res
        
def draw_pascal_triangle(n):
    pas_tri = []
    for i in range(n):
        pas_tri.append(getRow(i)) 

    for row in pas_tri:
        print(" ".join(map(str, row)).center(n * 3))
    
draw_pascal_triangle(10)



##################################
## Count Unique Observations df ##
##################################

import pandas as pd

def categories(df, strcols):
    for col in df.select_dtypes(include=strcols).columns:
        unique_count = df[col].nunique()
        print(f"{col}\n{unique_count}")

# Create sample data
data = {
    'Gender': ['Male', 'Male', 'Female', 'Male', 'Female', 'Male'],
    'Weight': ['Normal', 'Obese', 'Overweight', 'Normal', 'Normal', 'Obese']
}

# Create dataframe
df = pd.DataFrame(data)

# List of string datatypes
strcols = ['object']

# Call the function
categories(df, strcols)









