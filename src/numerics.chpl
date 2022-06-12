module numerics {
    use Chimera;
    
    proc inf(a : real) {return a;}
    proc sup(a : real) {return a;}
  
    proc inf(a : Interval) {return a.lo;}
    proc sup(a : Interval) {return a.hi;}
    
    proc mid(a) where isIntervalOrRealType(a.type) {
        return (inf(a) + sup(a))/2;
    }

    proc width(a) where isIntervalOrRealType(a.type) {
        return sup(a) - inf(a);
    }

    proc rad(a) where isIntervalOrRealType(a.type) {
        return max(sup(a) - mid(a), mid(a) - inf(a));
    }
}