use Chimera;
use List;

proc f(x) {return x**2 + 5*x + 6;}
proc df(x) {return 2 * x + 5;}

var X = new Interval(-4, 3);
var tol = 1e-10;

proc newton(X, tol) {
    var search_space : list(Interval);
    search_space.append(X);
    var roots : list(Interval);

    var cand, fncand, x1, x2 : Interval;
    while !(search_space.isEmpty()) {
        cand = search_space.first();
        search_space.pop(0);
        
        var new_cand = intersect(cand, mid(cand) - f(mid(cand)) * inv(df(cand)));
        fncand = f(new_cand);
        if isempty(new_cand) || !fncand.contains(0) then continue;

        if width(new_cand) <= tol then
            roots.append(new_cand);
        else {
            (x1, x2) = bisect(new_cand);
            search_space.append(x1);
            search_space.append(x2);
        }
    }
    return roots;
}

var roots = newton(X, tol);
writeln("Found ", roots.size, " intervals");
for root in roots {writeln(root, " f = ", f(root), " width = ", width(root));}
