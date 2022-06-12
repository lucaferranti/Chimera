use Chimera;
use List;

proc f1(x : Interval) {return exp(x) - 1;}
proc f2(x : Interval) {return x**2 + 5 * x + 6;}
var X = new Interval(-4, 3);
var tol = 1e-10;

proc bisect(f, X, tol) {
    var search_space : list(Interval);
    search_space.append(X);
    var roots : list(Interval);

    var cand, fcand, x1, x2 : Interval;
    while !(search_space.isEmpty()) {
        cand = search_space.first();
        search_space.pop(0);
        
        fcand = f(cand);
        if !fcand.contains(0) then continue;
        if width(cand) <= tol then
            roots.append(cand);
        else {
            (x1, x2) = bisect(cand);
            search_space.append(x1);
            search_space.append(x2);
        }
    }
    return roots;
}

var roots1 = bisect(f1, X, tol);
writeln("f(x) = exp(x) - 1, Found ", roots1.size, " intervals");
for root in roots1 {writeln(root, " width = ", width(root));}

var roots2 = bisect(f2, X, tol);
writeln("f(x) = x^2 + 5x + 6, found ", roots2.size, " intervals");
for root in roots2 {writeln(root, " width = ", width(root));}
