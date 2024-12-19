# -*- coding: utf-8 -*-
"""
Created on Wed Dec 18 21:17:36 2024

@author: alima
"""

def distribute_remaining_size(sizes, remaining_size, rankings):
    """
    Distributes the remaining size among the elements of the sizes array in a round-robin fashion,
    based on the ranking array.

    Args:
        sizes (list): The array of sizes to be updated.
        remaining_size (int): The remaining size to be distributed.
        rankings (list): The ranking array, where 0 has the highest priority and -1 means no allocation.

    Returns:
        list: The updated sizes array.
    """
    # Create a copy of the sizes array to avoid modifying the original array
    updated_sizes = sizes[:]

    # Create a list of indices to be updated, sorted by ranking
    indices_to_update = sorted((i for i, r in enumerate(rankings) if r!= -1), key=lambda i: rankings[i])

    # Distribute the remaining size in a round-robin fashion
    while remaining_size > 0:
        for i in indices_to_update:
            if remaining_size > 0:
                updated_sizes[i] += 1
                remaining_size -= 1
            else:
                break

    return updated_sizes

# Example usage
sizes = [0, 1, 2]
remaining_size = 5
rankings = [-1, 2, 1]

updated_sizes = distribute_remaining_size(sizes, remaining_size, rankings)
print(updated_sizes)  # Output: [0, 3, 5]
