
module boolean {
    use Chimera;

    operator ==(a, b) where isEitherInterval(a.type, b.type) {
      if isempty(a) then return isempty(b);
      return inf(a) == inf(b) && sup(a) == sup(b);
    }

    operator <=(a, b) where isEitherInterval(a.type, b.type) {
      if isempty(a) then return isempty(b);
      return inf(a) <= inf(b) && sup(a) <= sup(b);
    }

    proc _isless(a : real, b : real) {
      if isfinite(a) then return a < b;
      return a <= b;
    }

    operator <(a, b) where isEitherInterval(a.type, b.type) {
      if isempty(a) then return isempty(b);
      return _isless(inf(a), inf(b)) && _isless(sup(a), sup(b));
    }

    // precedes from the IEEE standard
    proc  precedes(a, b) where isEitherInterval(a.type, b.type) {
      if isempty(a) || isempty(b) then return true;
      return sup(a) <= inf(b);
    }

    proc strictprecedes(a, b) where isEitherInterval(a.type, b.type) {
      if isempty(a) || isempty(b) then return true;
      return sup(a) < inf(b);
    }

    proc isdisjoint(a, b) where isEitherInterval(a.type, b.type) {
      if isempty(a) || isempty(b) then return true;
      return sup(a) < inf(b) || inf(a) > sup(b);
    }

    proc isinterior(a, b) where isEitherInterval(a.type, b.type) {
      if isempty(a) then return true;
      return _isless(inf(b), inf(a)) && _isless(sup(a), sup(b));
    }
    proc Interval.contains(a : Interval){
        if isempty(a) then return true;
        return inf(this) <= inf(a) && sup(a) <= sup(this);
    }

    proc Interval.contains(a : real) {
      if isfinite(a) then return inf(this) <= a && a <= sup(this);
      return false;
    }

    // here I choose to represent the empty interval as [NaN, NaN]
    proc isempty(a : Interval) {
      return isnan(inf(a)) && isnan(sup(a));
    }

    proc isempty(a : real) {return false;}

    proc isentire(a) where isIntervalOrRealType(a.type) {
      return inf(a) == -INFINITY && sup(a) == INFINITY;
    }

    proc issingleton(a) where isIntervalOrRealType(a.type) {
      return inf(a) == sup(a);
    }

    proc iscommon(a) where isIntervalOrRealType(a.type) {
      return isfinite(inf(a)) && isfinite(sup(a));
    }


}