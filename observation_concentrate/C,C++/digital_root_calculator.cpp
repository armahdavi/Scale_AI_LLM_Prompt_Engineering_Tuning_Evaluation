#include <iostream>
#include <vector>
#include <sstream>

int digitalRoot(int n){

       while(n >= 10){

               std::vector<int> digits;
               std::stringstream ss;
               ss << n;
               for(char digit : ss.str()){
                      digits.push_back(digit - '0');
               }

               int digitSum = 0;
               for(int digit : digits){
                      digitSum += digit;
               }

               std::cout << n << "   -->   ";
               for(size_t i = 0; i < digits.size(); ++i){
                      std::cout << digits[i];
                      if(i < digits.size() - 1){
                            std::cout << " + ";
                      }
               }
               std::cout << " = " << digitSum << "   -->   ";

               n = digitSum;
       }
       
       std::cout << n << std::endl;
       return n;
}

int main(){

       std::vector<int> nums = {942, 457};

       for(int num : nums){
              int result = digitalRoot(num);
              std::cout << "The digital root of " << num << " is : " << result << std::endl;
       }

       return 0;
}