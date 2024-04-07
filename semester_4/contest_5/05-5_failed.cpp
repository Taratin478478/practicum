#include <map>
#include <iostream>
#include <vector>
#include <format>

constexpr unsigned long long MOD = 4294967161;

void map_to_csr(const std::map<unsigned long long, std::map<unsigned long long, unsigned long long>> &m,
                std::vector<unsigned long long> &values, std::vector<unsigned long long> &column_indices,
                std::vector<unsigned long long> &row_pointers) {
    unsigned long long count = 0;
    row_pointers.push_back(0);
    for (unsigned long long i = 0; i <= m.rbegin()->first; ++i) {
        if (m.contains(i)) {
            for (auto &d2: m.at(i)) {
                values.push_back(d2.second);
                column_indices.push_back(d2.first);
                ++count;
            }
        }
        row_pointers.push_back(count);
    }
}

int main() {
    std::map<unsigned long long, std::map<unsigned long long, unsigned long long>> m1, m2;
    unsigned long long a, b, c;
    while (std::cin >> a >> b >> c) {
        if (a == 0 && b == 0 && c == MOD) {
            break;
        }
        m1[a][b] = c % MOD;
    }
    while (std::cin >> a >> b >> c) {
        m2[b][a] = c % MOD;
    }

    //переводим в форматы CSR и CSC
    //сразу считать в него не получится тк элементы даются в произвольном порядке
    std::vector<unsigned long long> values1, column_indices1, row_pointers1, values2, column_indices2, row_pointers2;
    map_to_csr(m1, values1, column_indices1, row_pointers1);
    map_to_csr(m2, values2, column_indices2, row_pointers2);
    unsigned long long i, j, k, l, v;
    if (row_pointers1.size() <= 1 || row_pointers2.size() <= 1) {
        return 0;
    }
    for (i = 0; i < row_pointers1.size() - 1; ++i) {
        if (row_pointers1[i + 1] - row_pointers1[i]) {
            for (j = 0; j < row_pointers2.size() - 1; ++j) {
                v = 0;
                k = row_pointers1[i];
                l = row_pointers2[j];
                while (k < row_pointers1[i + 1] && l < row_pointers2[j + 1]) {
                    if (column_indices1[k] < column_indices2[l]) {
                        ++k;
                    } else if (column_indices2[l] < column_indices1[k]) {
                        ++l;
                    } else {
                        v += (values1[k] * values2[l]) % MOD;
                        ++k;
                        ++l;
                    }
                }
                if (v) {
                    std::cout << i << ' ' << j << ' ' << v % MOD << std::endl;
                }
            }
        }
    }
    return 0;
}