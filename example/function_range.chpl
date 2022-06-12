use Chimera;
use Time;
config param runInParallel = false;

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

proc bound(x : Interval, f, N : int = 0) : Interval {
    // ? apparently in recursive functions I need to explicitally write the return type?
    if N == 0 then return f(x);
    var (x1, x2) = bisect(x);
    var r1, r2 : Interval;
    serial runInParallel == false {
    //serial here.runningTasks() > here.maxTaskPar {
        cobegin with (ref r1, ref r2) {
            r1 = bound(x1, f, N - 1);
            r2 = bound(x2, f, N - 1);
        }
    }
    return hull(r1, r2);
}

for n in 0..10 {
    writeln("# bisections = ", n, " range = ", bound(x, f, n));
}

writeln("exact range = ", g(x));