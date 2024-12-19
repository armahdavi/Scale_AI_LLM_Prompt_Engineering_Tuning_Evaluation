/* 
Prompt is asking a list of beer rating and its descriptive statistics
*/


/* CHATBOT 1 CODE */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Function to calculate the average rating
double calculate_average(float ratings[], int size) {
    double sum = 0.0;
    for (int i = 0; i < size; i++) {
        sum += ratings[i];
    }
    return sum / size;
}

// Function to sort the ratings array in ascending order
void sort_ratings(float ratings[], int size) {
    for (int i = 0; i < size - 1; i++) {
        for (int j = i + 1; j < size; j++) {
            if (ratings[i] > ratings[j]) {
                float temp = ratings[i];
                ratings[i] = ratings[j];
                ratings[j] = temp;
            }
        }
    }
}

// Function to calculate the median rating
double calculate_median(float ratings[], int size) {
    sort_ratings(ratings, size);
    if (size % 2 == 0) {
        return (ratings[size / 2 - 1] + ratings[size / 2]) / 2;
    } else {
        return ratings[size / 2];
    }
}

// Function to calculate the 25th to 75th percentile
void calculate_percentile(float ratings[], int size) {
    sort_ratings(ratings, size);
    int q1_index = (int) ceil(size * 0.25);
    int q3_index = (int) floor(size * 0.75);
    printf("25th percentile: %.2f\n", ratings[q1_index - 1]);
    printf("75th percentile: %.2f\n", ratings[q3_index - 1]);
}

int main() {
    int size;
    printf("Enter the number of ratings: ");
    scanf("%d", &size);

    float ratings[size];
    printf("Enter the ratings (separated by space): ");
    for (int i = 0; i < size; i++) {
        scanf("%f", &ratings[i]);
    }

    double average = calculate_average(ratings, size);
    double median = calculate_median(ratings, size);

    printf("Average rating: %.2f\n", average);
    printf("Median rating: %.2f\n", median);

    calculate_percentile(ratings, size);

    return 0;
}



/* CHATBOT 1 CODE */
#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    float fa = *(const float*) a;
    float fb = *(const float*) b;
    return (fa > fb) - (fa < fb);
}

float findPercentile(float arr[], int n, float percentile) {
    float index = (percentile / 100.0) * (n + 1);
    int lowerIndex = (int)index;
    if (lowerIndex <= 0) return arr[0];
    if (lowerIndex >= n) return arr[n - 1];
    float fraction = index - lowerIndex;
    float result = arr[lowerIndex - 1] + fraction * (arr[lowerIndex] - arr[lowerIndex - 1]);
    return result;
}

int main() {
    float ratings[] = {2.5, 4.0, 3.5, 1.0, 2.0, 5.0, 3.0};
    int n = sizeof(ratings) / sizeof(ratings[0]);
    float sum = 0.0, average, median;

    // Sorting the array
    qsort(ratings, n, sizeof(float), compare);

    // Calculating average
    for (int i = 0; i < n; i++) {
        sum += ratings[i];
    }
    average = sum / n;

    // Finding median
    if (n % 2 == 0) {
        median = (ratings[n/2 - 1] + ratings[n/2]) / 2.0;
    } else {
        median = ratings[n/2];
    }

    // Calculating 25th and 75th percentiles
    float p25 = findPercentile(ratings, n, 25.0);
    float p75 = findPercentile(ratings, n, 75.0);

    // Printing the results
    printf("Average rating: %.2f\n", average);
    printf("Median rating: %.2f\n", median);
    printf("25th percentile: %.2f\n", p25);
    printf("75th percentile: %.2f\n", p75);

    return 0;
}
