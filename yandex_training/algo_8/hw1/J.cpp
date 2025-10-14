// J. Листы и вью*

#include <iostream>
#include <sstream>
#include <string>
#include <map>
#include <vector>

struct List {
    std::string base_name;
    unsigned long long l;
    unsigned long long r;
};

int main() 
{
    long long n;
    std::cin >> n;
    std::string s, com, lname, oldlname, val;
    std::stringstream ss, lss;
    std::map<std::string, std::vector<long long>> data;
    std::map<std::string, List> lists;
    unsigned long long lbracket, rbracket, del, lbound, rbound, i;
    long long x;
    std::getline(std::cin, s);
    for (int I = 0; I < n; ++I) {
        std::getline(std::cin, s);
        ss.clear();
        ss.str(s);
        std::getline(ss, com, ' ');
        if (com == "List") {
            std::getline(ss, lname, ' ');
            std::getline(ss, com, ' ');
            std::getline(ss, com, ' ');
            if (com == "new") {
                std::getline(ss, com, ' ');
                lbracket = com.find('(');
                rbracket = com.find(')');
                if (rbracket > lbracket + 1) {
                    com = com.substr(lbracket + 1, rbracket - lbracket - 1);
                    lss.clear();
                    lss.str(com);
                    data[lname] = {};
                    while (std::getline(lss, val, ',')) {
                        data[lname].push_back(std::stoll(val));
                    }
                    lists.emplace(lname, List{lname, 0, data[lname].size()});
                }
            } else {
                del = com.find('.');
                oldlname = com.substr(0, del);
                lbracket = com.find('(');
                rbracket = com.find(')');
                del = com.find(',');
                val = com.substr(lbracket + 1, del - lbracket - 1);
                lbound = std::stoll(val) - 1;
                val = com.substr(del + 1, rbracket - del - 1);
                rbound = std::stoll(val) - 1;
                lists.emplace(lname, List{lists[oldlname].base_name, lists[oldlname].l + lbound, lists[oldlname].l + rbound});
            }
        } else {
            del = s.find('.');
            lname = s.substr(0, del);
            lbracket = s.find('(');
            rbracket = s.find(')');
            com = s.substr(del + 1, lbracket - del - 1);
            if (com == "set") {
                del = s.find(',');
                val = s.substr(lbracket + 1, del - lbracket - 1);
                i = std::stoll(val) - 1;
                val = s.substr(del + 1, rbracket - del - 1);
                x = std::stoll(val);
                data[lists[lname].base_name][lists[lname].l + i] = x;
            } else if (com == "add" && data.contains(lname)) {
                val = s.substr(lbracket + 1, rbracket - lbracket - 1);
                x = std::stoll(val);
                data[lname].push_back(x);
                ++lists[lname].r;
            } else if (com == "get") {
                val = s.substr(lbracket + 1, rbracket - lbracket - 1);
                i = std::stoll(val) - 1;
                std::cout << data[lists[lname].base_name][lists[lname].l + i] << std::endl;
            }
        }
    }
	return 0;
}
