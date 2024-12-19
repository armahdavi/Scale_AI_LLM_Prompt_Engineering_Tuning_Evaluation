# -*- coding: utf-8 -*-
"""
Created on Wed Dec 18 12:39:06 2024

@author: alima
"""

import os

def find_files_by_extension(directory, extension):
    """
    Finds all files with a specific extension in a directory and its subdirectories.

    :param directory: Directory path to search
    :param extension: File extension to look for (e.g., '.sql', '.txt', '.csv')
    :return: List of file paths
    """
    matching_files = []
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(extension):
                matching_files.append(os.path.join(root, file))
    return matching_files

# Example usage:
path = r'C:\Outlier'

files = find_files_by_extension(path, '.sql')
file_names = [os.path.basename(x).replace('.sql','') for x in files]


files_py = find_files_by_extension(path, '.py')
file_names_py = [os.path.basename(x).replace('.py','') for x in files_py]

files_xlsx = find_files_by_extension(path, '.xlsx')
