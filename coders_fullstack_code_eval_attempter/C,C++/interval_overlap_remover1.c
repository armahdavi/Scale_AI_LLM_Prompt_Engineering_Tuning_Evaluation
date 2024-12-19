#include <stdio.h>
#include <stdlib.h>

// Define a structure for intervals
typedef struct {
    int start;
    int end;
} Interval;

// Comparator function for qsort to sort intervals by end time
int cmp(const void *a, const void *b) {
    Interval *ia = (Interval *)a;
    Interval *ib = (Interval *)b;
    if (ia->end < ib->end)
        return -1;
    else if (ia->end > ib->end)
        return 1;
    else
        return 0;
}

// Function to find the minimum number of intervals to remove
int eraseOverlapIntervals(Interval* intervals, int intervalsSize) {
    if (intervalsSize == 0)
        return 0;

    // Sort the intervals based on end times
    qsort(intervals, intervalsSize, sizeof(Interval), cmp);

    int count = 1;  // At least one interval doesn't overlap (the first one)
    int prev_end = intervals[0].end;

    // Iterate through the sorted intervals
    for (int i = 1; i < intervalsSize; i++) {
        if (intervals[i].start >= prev_end) {
            // No overlap; include this interval
            count++;
            prev_end = intervals[i].end;
        } else {
            // Overlapping interval; skip it
            // Not increasing count
        }
    }

    // The minimum number of intervals to remove
    return intervalsSize - count;
}

int main() {
    // Example intervals
    Interval intervals[] = {{1,2},{2,3},{3,4},{1,3}};
    int intervalsSize = sizeof(intervals)/sizeof(intervals[0]);

    int result = eraseOverlapIntervals(intervals, intervalsSize);
    printf("Minimum number of intervals to remove: %d\n", result);

    return 0;
}
