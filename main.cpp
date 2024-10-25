#include <iostream>
#include "class.h"

int main() {
    MyClass obj;
    int result = obj.FuncA();
    std::cout << "Result of FuncA: " << result << std::endl;
    return 0;
}
