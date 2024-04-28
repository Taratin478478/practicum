#include <iostream>
#include <stack>
#include <set>
#include <string>

int main() {
    std::stack<std::string> st;
    const std::set<char> ops{'+', '-', '*', '/'};
    char c;
    std::string x, y;
    while (std::cin >> c) {
        if (ops.contains(c)) {
            y = st.top();
            st.pop();
            x = st.top();
            st.pop();
            st.push('(' + x + c + y + ')');
        } else {
            x = c;
            st.push(x);
        }
    }
    std::cout << st.top() << std::endl;
}