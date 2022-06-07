use Chimera;

// the function whose range we want to compute
proc f(x : Interval) {
    return x ** 2 - x * infsup(2) + infsup(1);
}

// same function of before, but written in a better way to avoid dependency problem
proc g(x : Interval) {
    return (x - infsup(1)) ** 2;
}

// the domain
var x = infsup(1, 2);

// procedure to compute the function range with branch and bound. bisect iteratively the interval N times,
// evaluate the function over each sub interval and return the hull.
// This is pretty dumb, because the number of bisections is fixed, so I could have divided the interval into 2^N
// subintervals at once. This recursive approach would make sense if I had some stopping criteria
// e.g. compute the derivative with AD and stop when the function is monotone, or stop if the width
// is smaller than a given threshold.
proc bound(x : Interval, f, N : int = 0, acc : Interval = new Interval(NAN, NAN)) : Interval {
    // ? apparently in recursive functions I need to explicitally write the return type?
    if N == 0 then return f(x).hull(acc);
    var (x1, x2) = x.bisect;
    var r1 = bound(x1, f, N - 1, acc);
    return bound(x2, f, N - 1, r1);
}

for n in 0..10 {
    writeln("N = ", n, " range = ", bound(x, f, n));
}

writeln("exact range = ", g(x));