//////////////////////////////////////////////////////
// PROMPT: LOOK UP FILES IN A DIRECTORY USING C++17 //
//////////////////////////////////////////////////////

// RESPONSE 1 CODE GENERATION
#include <iostream>
#include <string>
#include <filesystem>
#include <vector>
#include <algorithm>
#include <stdexcept>

namespace fs = std::filesystem;

std::vector<std::string> listFiles(const std::string& path) {
    std::vector<std::string> files;

    try {
        for (const auto& entry : fs::directory_iterator(path)) {
            if (fs::is_regular_file(entry)) {
                files.push_back(entry.path().filename().string());
            }
        }
    } catch (const fs::filesystem_error& e) {
        throw std::runtime_error("Error accessing directory: " + std::string(e.what()));
    }

    std::sort(files.begin(), files.end());
    return files;
}

void printFiles(const std::vector<std::string>& files) {
    if (files.empty()) {
        std::cout << "No files found in the specified directory." << std::endl;
    } else {
        std::cout << "Files in the directory:" << std::endl;
        for (const auto& file : files) {
            std::cout << "- " << file << std::endl;
        }
    }
}

int main() {
    std::string path;

    std::cout << "Enter the directory path: ";
    std::getline(std::cin, path);

    try {
        if (!fs::exists(path)) {
            throw std::runtime_error("The specified path does not exist.");
        }

        if (!fs::is_directory(path)) {
            throw std::runtime_error("The specified path is not a directory.");
        }

        std::vector<std::string> files = listFiles(path);
        printFiles(files);
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}



// RESPONSE 2 CODE GENERATION
#include <iostream>
#include <filesystem>
#include <vector>
#include <stdexcept>

// Function to get the directory path from the user
std::filesystem::path getDirectoryPathFromUser() {
    std::filesystem::path path;
    while (true) {
        std::cout << "Enter the directory path: ";
        std::cin >> path;

        // Check if the path exists and is a directory
        if (std::filesystem::exists(path) && std::filesystem::is_directory(path)) {
            return path;
        } else {
            std::cout << "Invalid directory path. Please try again." << std::endl;
        }
    }
}

// Function to get the list of files in the directory
std::vector<std::filesystem::path> getFilesInDirectory(const std::filesystem::path& directoryPath) {
    std::vector<std::filesystem::path> files;

    try {
        // Iterate over the directory and add files to the vector
        for (const auto& entry : std::filesystem::directory_iterator(directoryPath)) {
            if (entry.is_regular_file()) {
                files.push_back(entry.path());
            }
        }
    } catch (const std::filesystem::filesystem_error& e) {
        std::cerr << "Error accessing directory: " << e.what() << std::endl;
        throw;
    }

    return files;
}

// Function to print the list of files
void printFiles(const std::vector<std::filesystem::path>& files) {
    std::cout << "Files in the directory:" << std::endl;
    for (const auto& file : files) {
        std::cout << file.filename() << std::endl;
    }
}

int main() {
    try {
        // Get the directory path from the user
        std::filesystem::path directoryPath = getDirectoryPathFromUser();

        // Get the list of files in the directory
        std::vector<std::filesystem::path> files = getFilesInDirectory(directoryPath);

        // Print the list of files
        printFiles(files);
    } catch (const std::exception& e) {
        std::cerr << "An error occurred: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}
