# -*- coding: utf-8 -*-
"""
Created on Wed Dec 18 18:29:19 2024

@author: alima
"""

import pandas as pd

# Read input file and collect its sheet names and data
input_file = r'C:\Outlier\Beagle Coding Prompt Generation\corporate.xlsx'
sheets_dict = pd.read_excel(input_file, sheet_name = None)

# Make a master file and populate it with the sheet data
df = pd.DataFrame([]) 

for key, value in sheets_dict.items():
    value['Project Manager'] = key
    
    df = pd.concat([df, value])

# Aggregate hours of each employee (by sum)
df = df.groupby(['Client', 'Project Manager'])[['Amir', 'Sasha', 'David',
                 'Batoul', 'Zara', 'Federico', 'Maya', 'Sathya', 'Kiran', 'Alex',
                 'Mohammed', 'Chris', 'Bob', 'Kamala', 'Bayram']].sum().reset_index()

# Create an output file and save each client data in a separate sheet of the output file
output_file = 'output_file.xlsx'
with pd.ExcelWriter(output_file) as writer:
    for client in df['Client'].unique():
        df_child = df[df['Client'] == client] 
        df_child.drop('Client', axis = 1)
        df_child.to_excel(writer, sheet_name = client, index = False)
        print(df_child.head())