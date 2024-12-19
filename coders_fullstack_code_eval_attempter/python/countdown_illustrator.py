# -*- coding: utf-8 -*-
"""
Created on Wed Dec 18 19:15:50 2024

@author: alima
"""

import time 

def countdown_and_alert(time_remaining): 
    while time_remaining > 0: 
        mins, secs = divmod(time_remaining, 60) 
        timer_display = '{:02d}:{:02d}'.format(mins, secs) 
        print(f"Time remaining: {timer_display}", end="\r") 
        time.sleep(1) 
        time_remaining -= 1
    
    print('Boom! Time\'s up!!') 

try:
    user_input = int(input("Set the countdown timer (in seconds): "))  
    countdown_and_alert(user_input)
except ValueError:
    print("Invalid input! Please enter a valid integer value for the countdown timer.")