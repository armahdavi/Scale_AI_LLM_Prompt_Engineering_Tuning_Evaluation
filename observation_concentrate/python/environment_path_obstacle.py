# -*- coding: utf-8 -*-
"""
Created on Thu Dec 19 02:01:03 2024

@author: alima
"""

####################
## CHATBOT 1 CODE ##
####################

from functools import lru_cache

def path_exists(grid):
    """
    Determines if a path exists from the top-left corner to the bottom-right corner
    in a grid represented by 0s (free) and 1s (obstacles).

    :param grid: List[List[int]] - 2D grid of 0s and 1s
    :return: bool - True if path exists, False otherwise
    """
    if not grid or not grid[0]:
        return False

    rows = len(grid)
    cols = len(grid[0])

    # If start or end is blocked, no path exists
    if grid[0][0] == 1 or grid[rows-1][cols-1] == 1:
        return False

    # Directions: up, down, left, right
    directions = [(-1,0), (1,0), (0,-1), (0,1)]

    @lru_cache(maxsize=None)
    def dfs(r, c):
        # If reached the bottom-right corner
        if r == rows - 1 and c == cols - 1:
            return True

        # Explore all possible directions
        for dr, dc in directions:
            nr, nc = r + dr, c + dc
            # Check boundaries and if the cell is free
            if 0 <= nr < rows and 0 <= nc < cols and grid[nr][nc] == 0:
                # Temporarily mark the cell as visited by setting it to 1
                grid[nr][nc] = 1
                if dfs(nr, nc):
                    return True
                # Unmark the cell (backtrack)
                grid[nr][nc] = 0
        return False

    # Start DFS from (0, 0)
    # Mark the starting cell as visited
    grid[0][0] = 1
    return dfs(0, 0)

# Example usage:
if __name__ == "__main__":
    environment = [
        [0, 0, 1, 0],
        [1, 0, 1, 0],
        [0, 0, 0, 1],
        [0, 1, 0, 0]
    ]

    result = path_exists(environment)
    print("Path exists:" , result)  # Output: Path exists: True or False



####################
## CHATBOT 2 CODE ##
####################

from functools import lru_cache

def path_exists(grid):
    if not grid or not grid[0]:
        return False
    
    rows, cols = len(grid), len(grid[0])
    
    @lru_cache(maxsize=None)
    def dfs(i, j):
        # Base cases
        if i == rows - 1 and j == cols - 1:
            return True
        if i >= rows or j >= cols or grid[i][j] == 1:
            return False
        
        # Recursive cases
        return dfs(i+1, j) or dfs(i, j+1)
    
    return dfs(0, 0)

# Example usage
grid1 = [
    [0, 0, 0],
    [1, 1, 0],
    [1, 1, 0]
]

grid2 = [
    [0, 1, 0],
    [0, 1, 0],
    [0, 1, 0]
]

print(path_exists(grid1))  # Output: True
print(path_exists(grid2))  # Output: False
