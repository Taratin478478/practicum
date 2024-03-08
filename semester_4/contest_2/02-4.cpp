#include <string>

using namespace std;

class BinaryNumber
{
    string s;
public:
    BinaryNumber(const string &s): s(s) {}
    operator string () const {
        return s;
    }
    const BinaryNumber &operator++() {
        for (int i = s.length() - 1; i >= 0; --i) {
            if (s[i] == '0') {
                s[i] = '1';
                return *this;
            } else {
                s[i] = '0';
            }
        }
        s.insert(0, "1");
        return *this;
    };
};
