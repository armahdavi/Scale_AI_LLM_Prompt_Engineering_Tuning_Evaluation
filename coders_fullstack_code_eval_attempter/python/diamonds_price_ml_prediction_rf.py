# -*- coding: utf-8 -*-
"""
Created on Wed Dec 18 21:11:48 2024

@author: alima
"""


# Import necessary libraries
import pandas as pd  # For data manipulation and analysis
from sklearn.model_selection import train_test_split  # For splitting the dataset into training and testing sets
from sklearn.ensemble import RandomForestRegressor  # For the Random Forest Regression model
from sklearn.metrics import mean_squared_error  # For evaluating the model's performance

# Load the data from a CSV file and drop unnecessary columns
df = pd.read_csv('Diamonds_Prices.csv').drop(columns={'Unnamed: 0', 'x', 'y', 'z', "cut", "color", "clarity"})

# Define the feature set (X) by dropping the 'price' column from the dataframe
X = df.drop(columns=['price'])

# Define the target variable (y) which is the 'price' column
y = df['price']

# Split the data into training and testing sets (80% training, 20% testing)
# The random_state parameter ensures reproducibility of the split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Initialize the RandomForestRegressor model with 100 trees and a random_state for reproducibility
model = RandomForestRegressor(n_estimators=100, random_state=42)

# Train the model using the training data
model.fit(X_train, y_train)

# Use the trained model to make predictions on the test data
y_pred = model.predict(X_test)

# Calculate the Mean Squared Error (MSE) between the actual and predicted values
mse = mean_squared_error(y_test, y_pred)

# Print the Mean Squared Error
print("Mean Squared Error:", mse)