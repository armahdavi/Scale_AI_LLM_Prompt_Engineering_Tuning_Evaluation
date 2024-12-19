# -*- coding: utf-8 -*-
"""
Simple Gradient Descent (GD) calculation based on numpy only

@author: alima
"""

#############################
## CHATBOT 1 RESPONSE CODE ##
#############################

import numpy as np

# Define the function f(x, y)
def f(x, y):
    return (x - 5)**2 + (y - 8)**2

# Compute the gradient of f at point (x, y)
def gradient(x, y):
    df_dx = 2 * (x - 5)
    df_dy = 2 * (y - 8)
    return np.array([df_dx, df_dy])

# Gradient descent algorithm
def gradient_descent(learning_rate=0.1, max_iterations=1000, tolerance=1e-6):
    # Initialize variables
    x, y = 0.0, 0.0  # Starting point (x0, y0)
    history = []     # To store the history of function values

    for i in range(max_iterations):
        # Compute the gradient at the current point
        grad = gradient(x, y)

        # Update the variables
        x_new = x - learning_rate * grad[0]
        y_new = y - learning_rate * grad[1]

        # Compute the change in function value
        f_current = f(x, y)
        f_new = f(x_new, y_new)
        func_change = abs(f_new - f_current)

        # Store the function value
        history.append(f_new)

        # Check for convergence
        if func_change < tolerance:
            print(f"Converged after {i+1} iterations.")
            break

        # Update variables for next iteration
        x, y = x_new, y_new

    return x, y, history

# Run the gradient descent algorithm
minimum_x, minimum_y, history = gradient_descent()

print(f"The function reaches its minimum at x = {minimum_x}, y = {minimum_y}")
print(f"Minimum value of the function is f({minimum_x}, {minimum_y}) = {f(minimum_x, minimum_y)}")


import matplotlib.pyplot as plt

# Plot the convergence of the function value
plt.plot(history)
plt.xlabel('Iteration')
plt.ylabel('Function Value')
plt.title('Convergence of Gradient Descent')
plt.grid(True)
plt.show()



#############################
## CHATBOT 2 RESPONSE CODE ##
#############################

import numpy as np

def function(x):
    """The function to be minimized"""
    return (x[0] - 5)**2 + (x[1] - 8)**2

def gradient(x):
    """The gradient of the function"""
    return np.array([2*(x[0] - 5), 2*(x[1] - 8)])

def gradient_descent(start_point, learning_rate, num_iterations, tolerance):
    """Perform gradient descent to minimize the function"""
    x = start_point
    for i in range(num_iterations):
        grad = gradient(x)
        new_x = x - learning_rate * grad
        
        # Check for convergence
        if np.linalg.norm(new_x - x) < tolerance:
            print(f"Converged after {i+1} iterations")
            return new_x
        
        x = new_x
        
        if (i+1) % 100 == 0:
            print(f"Iteration {i+1}: x = {x}, f(x) = {function(x)}")
    
    print(f"Reached maximum iterations ({num_iterations})")
    return x

# Set parameters
start_point = np.array([0.0, 0.0])
learning_rate = 0.1
num_iterations = 1000
tolerance = 1e-6

# Run gradient descent
result = gradient_descent(start_point, learning_rate, num_iterations, tolerance)

print(f"\nFinal result: x = {result}")
print(f"Function value at minimum: f(x) = {function(result)}")
