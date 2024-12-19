# -*- coding: utf-8 -*-
"""
Created on Wed Dec 18 21:26:37 2024

@author: alima
"""

import numpy as np

def sigmoid(x):
    return 1 / (1 + np.exp(-x))

# Test cases
def test_sigmoid():
    print("Running sigmoid function test cases:")
    
    # Test case 1: Check sigmoid(0)
    # Expected result: 0.5 (midpoint of sigmoid function)
    result = sigmoid(0)
    print(f"1. sigmoid(0) = {result:.6f}")
    assert np.isclose(result, 0.5), "Test case 1 failed"

    # Test case 2: Check sigmoid of a large positive number
    # Expected result: Very close to 1
    result = sigmoid(100)
    print(f"2. sigmoid(100) = {result:.6f}")
    assert np.isclose(result, 1), "Test case 2 failed"

    # Test case 3: Check sigmoid of a large negative number
    # Expected result: Very close to 0
    result = sigmoid(-100)
    print(f"3. sigmoid(-100) = {result:.6f}")
    assert np.isclose(result, 0), "Test case 3 failed"

    # Test case 4: Check sigmoid of 1
    # Expected result: Approximately 0.7310585786300049
    result = sigmoid(1)
    print(f"4. sigmoid(1) = {result:.6f}")
    assert np.isclose(result, 0.7310585786300049), "Test case 4 failed"

    # Test case 5: Check sigmoid of -1
    # Expected result: Approximately 0.2689414213699951
    result = sigmoid(-1)
    print(f"5. sigmoid(-1) = {result:.6f}")
    assert np.isclose(result, 0.2689414213699951), "Test case 5 failed"

    # Test case 6: Check sigmoid with a numpy array input
    # Expected result: Array of sigmoid values
    input_array = np.array([-2, -1, 0, 1, 2])
    result = sigmoid(input_array)
    print(f"6. sigmoid([-2, -1, 0, 1, 2]) = {result}")
    expected = np.array([0.11920292, 0.26894142, 0.5, 0.73105858, 0.88079708])
    assert np.allclose(result, expected), "Test case 6 failed"

    print("All test cases passed successfully!")

# Run the test cases
test_sigmoid()


