#include <vector>
#include <array>
#include <complex>

namespace Equations {
    template <typename T>
    std::pair<bool, std::vector<T>> quadratic(const std::array<T, 3> &arr) {
        std::vector<T> res;
        if (std::norm(arr[2]) < 32 * std::numeric_limits<typename T::value_type>::epsilon()) {
            if (std::norm(arr[1]) < 32 * std::numeric_limits<typename T::value_type>::epsilon()) {
                if (std::norm(arr[0]) < 32 * std::numeric_limits<typename T::value_type>::epsilon()) {
                    return std::make_pair(false, res);
                } else {
                    return std::make_pair(true, res);
                }
            } else {
                res.push_back(-arr[0] / arr[1]);
                return std::make_pair(true, res);
            }
        } else {
            T d = std::sqrt(arr[1] * arr[1] - T{4} * arr[2] * arr[0]);
            res.push_back((-arr[1] - d) / (T{2} * arr[2]));
            res.push_back((-arr[1] + d) / (T{2} * arr[2]));
            return std::make_pair(true, res);
        }
    }
}