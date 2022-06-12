
module boolean {
    use Chimera;

    operator ==(a, b) where isEitherInterval(a.type, b.type) {
      return inf(a) == inf(b) && sup(a) == sup(b);
    }

    // here I choose to represent the empty interval as [NaN, NaN]
    proc isempty(a : Interval) {
      return isnan(inf(a)) && isnan(sup(a));
    }

    proc isempty(a : numeric) {return false;}

    proc Interval.contains(a : real) {
        return inf(this) <= a && a <= sup(this);
    }

}