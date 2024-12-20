#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int trapRainwater(vector<int>& height) {
    int n = height.size();
    if (n <= 2) {
        return 0; // No water can be trapped with less than 3 walls
    }

    int left = 0;
    int right = n - 1;
    int leftMax = 0;
    int rightMax = 0;
    int trappedWater = 0;

    while (left < right) {
        if (height[left] <= height[right]) {
            leftMax = max(leftMax, height[left]);
            trappedWater += leftMax - height[left];
            left++;
        } else {
            rightMax = max(rightMax, height[right]);
            trappedWater += rightMax - height[right];
            right--;
        }
    }

    return trappedWater;
}

int main() {
    vector<int> height = {0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1};
    cout << "Trapped rainwater: " << trapRainwater(height) << endl; 

    vector<int> height2 = {4, 2, 0, 3, 2, 5};
    cout << "Trapped rainwater: " << trapRainwater(height2) << endl;

    return 0;
}