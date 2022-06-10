/* Documentation for chimera */
module Chimera {
  record Interval {
    var lo : real;
    var hi : real;
  }

    proc isIntervalType(type t: Interval) param { return true; }
    proc isIntervalType(type t) param { return false; }
    proc isEitherInterval(type t, type s) param { return isIntervalType(t) || isIntervalType(s); }

    public use arithmetic;

    public use transcendental;
    // BOOLEANS

    operator Interval.==(a : Interval, b : Interval) {
      return a.lo == b.lo && a.hi == b.hi;
    }

    operator Interval.==(a : Interval, b : real) {
      return a.lo == b && a.hi == b;
    }

    // here I choose to represent the empty interval as [NaN, NaN]
    proc Interval.isempty {
      return isnan(this.lo) && isnan(this.hi);
    }

    // SET OPERATIONS
    proc Interval.hull(b : Interval) {
      if this.isempty then return b;
      if b.isempty then return this;
      return new Interval(min(this.lo, b.lo), max(this.hi, b.hi));
    }

    // NUMERICS
    proc Interval.mid {
      return (this.lo + this.hi)/2;
    }

    proc Interval.bisect {
      return (new Interval(this.lo, this.mid), new Interval(this.mid, this.hi));
    }


  proc inf(a : real) {return a;}
  proc sup(a : real) {return a;}
  
  proc inf(a : Interval) {return a.lo;}
  proc sup(a : Interval) {return a.hi;}

  //  
  proc is_invalid_interval(lo : real, hi : real) {
    return lo > hi || lo == INFINITY || hi == -INFINITY || isnan(lo) || isnan(hi);
  }

  proc infsup(lo : real, hi : real) {
    if is_invalid_interval(lo, hi) then
      return new Interval(NAN, NAN);
    else
      return new Interval(lo, hi);
  }

  proc infsup(lo : real) {
    return new Interval(lo, lo);
  }

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
