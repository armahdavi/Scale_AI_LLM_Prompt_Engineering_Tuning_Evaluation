#include <stdio.h>
#include <stdlib.h>

// Structure to represent an interval
typedef struct {
    int start;
    int end;
} Interval;

// Function to compare two intervals based on their end points
int compareIntervals(const void *a, const void *b) {
    Interval *intervalA = (Interval *)a;
    Interval *intervalB = (Interval *)b;
    return intervalA->end - intervalB->end;
}

// Function to find the minimum number of intervals to remove
int eraseOverlapIntervals(Interval *intervals, int intervalsSize) {
    if (intervalsSize <= 1) return 0;

    // Sort the intervals based on their end points
    qsort(intervals, intervalsSize, sizeof(Interval), compareIntervals);

    int prevEnd = intervals[0].end;
    int count = 0;

    for (int i = 1; i < intervalsSize; i++) {
        if (intervals[i].start < prevEnd) {
            count++;
        } else {
            prevEnd = intervals[i].end;
        }
    }

    return count;
}

int main() {
    Interval intervals[] = {{1, 2}, {2, 3}, {3, 4}, {1, 3}};
    int intervalsSize = sizeof(intervals) / sizeof(intervals[0]);

    int result = eraseOverlapIntervals(intervals, intervalsSize);
    printf("Minimum number of intervals to remove: %d\n", result);

    return 0;
}