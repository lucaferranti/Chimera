use Chimera;
use Time;
config param runInParallel = true;

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
proc bound(x : Interval, f, N : int = 0) : Interval {
    // ? apparently in recursive functions I need to explicitally write the return type?
    if N == 0 then return f(x);
    var (x1, x2) = x.bisect;
    var r1, r2 : Interval;
    serial runInParallel == false {
    //serial here.runningTasks() > here.maxTaskPar {
        cobegin with (ref r1, ref r2) {
            r1 = bound(x1, f, N - 1);
            r2 = bound(x2, f, N - 1);
        }
    }
    sleep(0.1);
    return r1.hull(r2);
}

var r = bound(x, f, 10);
// x - x = rad(x)[-1, 1]
//x = [1, 2] = diam([1, 2])*[-1, 1] = [-1, 1]
// x1 = [1, 1.5] x2 = [1.5, 2]
// x1 - x1 = 0.5*[-1, 1] = [-0.5, 0.5]
// x2 - x2 = 0.5*[-1, 1] = [-0.5, 0.5]
// f(x) > 0 || f(x) < 0 --> f does not have a root in x
// for n in 0..10 {
//     writeln("N = ", n, " range = ", bound(x, f, n));
// }

// writeln("exact range = ", g(x));