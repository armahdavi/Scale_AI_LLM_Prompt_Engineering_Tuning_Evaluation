/* CHATBOT 1 RESPONSE CODE */

#include <iostream>
#include <vector>
#include <iomanip>
#include <string>

std::vector<int> getRow(int rowIndex) {
    std::vector<int> res = {1};
    long long prev = 1;
    for (int k = 1; k <= rowIndex; ++k) {
        long long next_val = prev * (rowIndex - k + 1) / k;
        res.push_back(next_val);
        prev = next_val;
    }
    return res;
}

void draw_pascal_triangle(int n) {
    std::vector<std::vector<int>> pas_tri;
    for (int i = 0; i < n; ++i) {
        pas_tri.push_back(getRow(i));
    }

    for (const auto& row : pas_tri) {
        std::string line;
        for (int num : row) {
            line += std::to_string(num) + " ";
        }
        // Remove trailing space
        if (!line.empty()) {
            line.pop_back();
        }
        // Calculate padding for centering
        int padding = (n * 3 - line.length()) / 2;
        std::cout << std::string(padding, ' ') << line << std::endl;
    }
}

int main() {
    draw_pascal_triangle(10);
    return 0;
}



/* CHATBOT 2 RESPONSE CODE */

//#include <iostream>
//#include <vector>
//#include <iomanip>
//#include <string>

std::vector<int> getRow(int rowIndex) {
    std::vector<int> res = {1};
    long long prev = 1;
    for (int k = 1; k <= rowIndex; ++k) {
        long long next_val = prev * (rowIndex - k + 1) / k;
        res.push_back(next_val);
        prev = next_val;
    }
    return res;
}

void draw_pascal_triangle(int n) {
    std::vector<std::vector<int>> pas_tri;
    for (int i = 0; i < n; ++i) {
        pas_tri.push_back(getRow(i));
    }

    for (const auto& row : pas_tri) {
        std::string line;
        for (int num : row) {
            line += std::to_string(num) + " ";
        }
        // Remove trailing space
        if (!line.empty()) {
            line.pop_back();
        }
        // Calculate padding for centering
        int padding = (n * 3 - line.length()) / 2;
        std::cout << std::string(padding, ' ') << line << std::endl;
    }
}

int main() {
    draw_pascal_triangle(10);
    return 0;
}
