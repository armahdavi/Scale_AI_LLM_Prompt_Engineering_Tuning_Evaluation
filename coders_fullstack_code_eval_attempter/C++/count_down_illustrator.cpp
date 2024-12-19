#include <iostream>
#include <iomanip>   // For std::setw and std::setfill
#include <chrono>    // For std::chrono::seconds
#include <thread>    // For std::this_thread::sleep_for
#include <string>    // For std::string
#include <stdexcept> // For std::invalid_argument and std::out_of_range exceptions

void countdown_and_alert(int time_remaining) {
    while (time_remaining > 0) {
        int mins = time_remaining / 60;
        int secs = time_remaining % 60;
        std::cout << "Time remaining: "
                  << std::setw(2) << std::setfill('0') << mins << ":"
                  << std::setw(2) << std::setfill('0') << secs
                  << "\r" << std::flush;
        std::this_thread::sleep_for(std::chrono::seconds(1));
        --time_remaining;
    }
    std::cout << std::endl << "Boom! Time's up!!" << std::endl;
}

int main() {
    std::cout << "Set the countdown timer (in seconds): ";
    std::string user_input_str;
    std::getline(std::cin, user_input_str);

    try {
        int user_input = std::stoi(user_input_str);
        if (user_input < 0) {
            throw std::invalid_argument("Negative value");
        }
        countdown_and_alert(user_input);
    } catch (const std::invalid_argument&) {
        std::cout << "Invalid input! Please enter a valid integer value for the countdown timer." << std::endl;
    } catch (const std::out_of_range&) {
        std::cout << "Input value is out of range." << std::endl;
    }

    return 0;
}