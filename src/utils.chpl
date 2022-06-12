module utils {
    proc _min_no_nan(a : real, b : real) {
        if isnan(a) then return b;
        if isnan(b) then return a;
        return min(a, b);
    }

  proc _max_no_nan(a : real, b : real) {
        if isnan(a) then return b;
        if isnan(b) then return a;
        return max(a, b);
    }
}