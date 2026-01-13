#include "sort.hpp"
#include <algorithm>

void mySort(std::vector<int>& v) {
    std::stable_sort(v.begin(), v.end());
}