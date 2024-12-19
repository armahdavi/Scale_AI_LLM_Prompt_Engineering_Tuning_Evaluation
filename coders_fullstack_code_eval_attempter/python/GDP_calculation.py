# -*- coding: utf-8 -*-
"""
Created on Wed Dec 18 22:51:23 2024

@author: alima
"""

country = []
consumption = []
investment = []
government_spending = [] 
exports = []
          
def fileReading(fileName):
    f = open(fileName, "r")
    for x in f:
        line = x.split(" ")
        country.append(line[0])
        consumption.append(float(line[1]))
        investment.append(float(line[2]))
        government_spending.append(float(line[3]))
        exports.append(float(line[4]))
    
def calculateGDP():
    GDP=[]
    for idx in range(len(country)):
        GDP.append((country[idx],consumption[idx] + investment[idx] + government_spending[idx] + exports[idx]))
    return GDP
    
if __name__ == "__main__":
    fileName="C:\Outlier\Square BlackBerry\Session5_240919\GDP.txt"
    fileReading(fileName)
    GDP=calculateGDP()
    print(GDP)
