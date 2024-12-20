# -*- coding: utf-8 -*-
"""
Created on Fri Dec 20 02:04:58 2024

@author: alima
"""

# Importing essential modules 
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.model_selection import cross_val_score
from sklearn.naive_bayes import GaussianNB

# Reading your csv file of text and ratings
path = r'C:/Outlier/raw_files/1429_1.csv'
df = pd.read_csv(path)

# Keeping text and ratings columns (if more than two columns exist)

df = df[['text', 'rating']]

# Replacing 1-2 with negative, 3 with neutral, and 4-5 with positive
rating_dict = {1: 'negative',
               2: 'negative',
               3: 'neutral',
               4: 'positive',
               5: 'positive'}

df['rating'].replace(rating_dict, inplace = True)

# Setting up features and labels for your model
X = df['text']
y = df['rating']

# Implementing tf-idf vectorizer to your model
vectorizer = TfidfVectorizer(max_df = 0.5, min_df = 25)
X_tfidf = vectorizer.fit_transform(X).toarray()  

# Model selection and 5-fold cross validation
model = GaussianNB()
cross_val_scores = cross_val_score(model, X_tfidf, y, cv = 5, scoring = 'accuracy')


# Print the cross-validation scores
print("Cross-validation scores:", cross_val_scores)
print("Mean of cross-validation scores:", cross_val_scores.mean())
print("Standard deviation of cross-validation score:", cross_val_scores.std())