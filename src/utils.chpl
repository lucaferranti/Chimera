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

    const FMAX       = 0x1.FFFFFFFFFFFFFp+1023;
    const EPS        = 0x1p-53;
    const PHI        = 0x1.0000000000001p-53;
    const EPSINV     = 0x1p53;
    const ETA        = 0x1p-1074;
    const FMIN2      = 0x1p-1021;
    const EPSINVFMIN = 0x1p-969;

    proc nextup(c : real) {
        if abs(c) >= EPSINVFMIN then
            return if c == -INFINITY then -FMAX else c + PHI * abs(c);
        else if abs(c) < FMIN2 then return c + ETA;
        else {
        var C = EPSINV * c,
            e = PHI * abs(C);
        return EPS * (C + e);
        }
    }

    proc nextdown(c : real) {
        if abs(c) >= EPSINVFMIN then
            return if c == INFINITY then FMAX else c - PHI * abs(c);
        else if abs(c) < FMIN2 then return c - ETA;
        else {
        var C = EPSINV * c,
            e = PHI * abs(C);
        return EPS * (C - e);
        }
    }

    proc nextout(c : real) {
        if abs(c) >= EPSINVFMIN then {
        if !isinf(c) then return (c - PHI * abs(c), c + PHI * abs(c));
        if signbit(c) then return (-INFINITY, -FMAX);
        return (FMAX, INFINITY);
        }
        else if abs(c) < FMIN2 then return (c - ETA, c + ETA);
        else {
        var C = EPSINV * c,
            e = PHI * abs(C);
        return (EPS * (C - e), EPS * (C + e));
        }
    }
}