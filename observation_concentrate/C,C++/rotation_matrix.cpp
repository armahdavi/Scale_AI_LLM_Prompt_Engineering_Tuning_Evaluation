#include <iostream>
#include <cmath>
#include <array>

std::array<std::array<double, 3>, 3> rot(double x, double y, double z) {
  std::array<std::array<double, 3>, 3> R_x = { { {1, 0, 0}, {0, cos(x), -sin(x)}, {0, sin(x), cos(x)} } };
  std::array<std::array<double, 3>, 3> R_y = { { {cos(y), 0, sin(y)}, {0, 1, 0}, {-sin(y), 0, cos(y)} } };
  std::array<std::array<double, 3>, 3> R_z = { { {cos(z), -sin(z), 0}, {sin(z), cos(z), 0}, {0, 0, 1} } };

  std::array<std::array<double, 3>, 3> temp;
  std::array<std::array<double, 3>, 3> result;

  // Multiply R_z * R_y
  for (int i = 0; i < 3; ++i) {
    for (int j = 0; j < 3; ++j) {
      temp[i][j] = 0;
      for (int k = 0; k < 3; ++k) {
        temp[i][j] += R_z[i][k] * R_y[k][j];
      }
    }
  }

  // Multiply (R_z * R_y) * R_x
  for (int i = 0; i < 3; ++i) {
    for (int j = 0; j < 3; ++j) {
      result[i][j] = 0;
      for (int k = 0; k < 3; ++k) {
        result[i][j] += temp[i][k] * R_x[k][j];
      }
    }
  }

  return result;
}



int main() {
    double x = 0.5, y = 0.21, z = 0.7;
    auto result = rot(x, y, z);

    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j < 3; ++j) {
            std::cout << result[i][j] << " ";
        }
        std::cout << std::endl;
    }

    return 0;
}