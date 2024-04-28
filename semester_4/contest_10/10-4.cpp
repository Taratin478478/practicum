#include <iostream>
#include <stack>
#include <set>

char c;

void gc() {
    std::cin >> c;
    if (std::cin.eof()) {
        c = 0;
    }
}

struct expr {
    std::string str;
    int prio = 0;
};

std::set ops = {'+', '-', '*', '/', '&', '^', '|'};

int get_prio(char op) {
    if (op == '*' || op == '/') {
        return 5;
    } else if (op == '+' || op == '-') {
        return 4;
    } else if (op == '&') {
        return 3;
    } else if (op == '^') {
        return 2;
    } else if (op == '|') {
        return 1;
    } else if (op == 0 || op == ')') {
        return 0;
    } else {
        throw op;
    }
}

expr E(int last_prio) {
    expr res;
    if (c == 0) {
        return res;
    } else if (c == '(') {
        gc();
        res = E(0);
        int new_prio = get_prio(c);
        bool par = false;
        if (res.prio > 0 && !((last_prio < res.prio || last_prio == 0) && new_prio <= res.prio)) {
            res.str = '(' + res.str + ')';
            par = true;
        }
        expr next = E(new_prio);
        res.str += next.str;
        if (par) {
            res.prio = next.prio;
        } else if (next.prio > 0) {
            res.prio = std::min(res.prio, next.prio);
        }
    } else if (ops.contains(c)) {
        char op = c;
        gc();
        res = E(get_prio(op));
        res.str = op + res.str;
        if (res.prio > 0) {
            res.prio = std::min(get_prio(op), res.prio);
        } else {
            res.prio = get_prio(op);
        }
    } else if (c != ')') {
        char arg = c;
        gc();
        res = E(last_prio);
        res.str = arg + res.str;
    } else {
        gc();
    }
    return res;
}

int main() {
    gc();
    std::cout << E(0).str << std::endl;
}