// B. Из тупика в тупик

#include <iostream>
#include <vector>

int traverse_tree(const auto &tree, int i, int prev, int d, int res, bool f) {
    ++d;
    if (tree[i].size() == 1) {
        if (f) {
            res = std::min(res, d);
        } else {
            f = true;
        }
        d = 0;
    }
    for (int j: tree[i]) {
        if (j != prev) {
            res = std::min(res, traverse_tree(tree, j, i, d, res, f));
        }
    }
    return res;
}

int main() {
    int n, a, b; 
    std::cin >> n;
    std::vector<std::vector<int>> tree(n, std::vector<int>());
    for (int i = 0; i < n - 1; ++i) {
        std::cin >> a >> b;
        tree[a - 1].push_back(b - 1);
        tree[b - 1].push_back(a - 1);
    }
    int start;
    for (int i = 0; i < n - 1; ++i) {
        if (tree[i].size() == 1) {
            start = i;
            break;
        }
    }
    std::cout << traverse_tree(tree, start, -1, 0, n + 1, false) << std::endl;
}