#include <stdio.h>
#include <stdlib.h>

/**
 * Merge two sorted arrays into a new array.
 *
 * @param nums1 The first sorted array.
 * @param m The number of elements in the first array.
 * @param nums2 The second sorted array.
 * @param n The number of elements in the second array.
 * @return A new array containing the merged elements.
 */
int* merge_2_arrays(int* nums1, int m, int* nums2, int n) {
    // Allocate memory for the new array
    int* merged = (int*) malloc((m + n) * sizeof(int));

    int i = 0; // Index for nums1
    int j = 0; // Index for nums2
    int k = 0; // Index for the merged array

    // Merge smaller elements first
    while (i < m && j < n) {
        if (nums1[i] < nums2[j]) {
            merged[k] = nums1[i];
            i++;
        } else {
            merged[k] = nums2[j];
            j++;
        }
        k++;
    }

    // Copy remaining elements from nums1, if any
    while (i < m) {
        merged[k] = nums1[i];
        i++;
        k++;
    }

    // Copy remaining elements from nums2, if any
    while (j < n) {
        merged[k] = nums2[j];
        j++;
        k++;
    }

    return merged;
}

int main() {
    int nums1[] = {1, 2, 3};
    int m = 3;
    int nums2[] = {2, 5, 6};
    int n = 3;

    int* merged = merge_2_arrays(nums1, m, nums2, n);

    printf("Merged Array: [");
    for (int i = 0; i < m + n; i++) {
        printf("%d", merged[i]);
        if (i < m + n - 1) {
            printf(", ");
        }
    }
    printf("]\n");

    // Don't forget to free the allocated memory
    free(merged);

    return 0;
}