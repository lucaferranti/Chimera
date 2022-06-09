/* Documentation for chimera */
module Chimera {
  record Interval {
    var lo : real;
    var hi : real;

    // ? I don't understand why this is needed
    proc init(lo : real, hi : real) {
      this.lo = lo;
      this.hi = hi;
    }

    proc init=(from: Interval) {
      this.lo = from.lo;
      this.hi = from.hi;
    }

    // ! THIS OPERATIONS ARE CURRENTLY NOT USING DIRECTED ROUNDED 
    // ? is there a way to avoid manually definiing all mixed cases (interval, real), (real, interval), (interval, interval) ?
    operator +(a : Interval, b : Interval) {
      return new Interval(a.lo + b.lo, a.hi + b.hi);
    }

    operator -(a : Interval, b : Interval) {
      return new Interval(a.lo - b.hi, a.hi - b.lo);
    }

    operator *(a : Interval, b : Interval) {
      if a.isempty || b.isempty then return new Interval(NAN, NAN);
      if a == 0 || b == 0 then return new Interval(0, 0);
      var lolo = a.lo * b.lo,
          lohi = a.lo * b.hi,
          hilo = a.hi * b.lo,
          hihi = a.hi * b.hi;

      return new Interval(_min_no_nan(_min_no_nan(lolo, lohi), _min_no_nan(hilo, hihi)), _max_no_nan(_max_no_nan(lolo, lohi), _max_no_nan(hilo, hihi)));
    }

    proc inv {
      if this == 0 || this.isempty then return new Interval(NAN, NAN);
      
      if this.lo > 0 || this.hi < 0 then
          return new Interval(1 / this.hi, 1 / this.lo);
      else if this.lo == 0 then
          return new Interval(1 / this.hi, INFINITY);
      else if this.hi == 0 then 
        return new Interval(-INFINITY, 1 / this.lo);
      else
        return new Interval(-INFINITY, INFINITY);
    }

    operator **(a : Interval, n : int) {
      if n % 2 then 
        return new Interval(a.lo ** n, a.hi ** n);
      else {
        if a.lo <= 0 && 0 <= a.hi then
          return new Interval(0, max(abs(a.lo), abs(a.hi)) ** n); 
        else
          return new Interval(min(abs(a.lo), abs(a.hi)) ** n, max(abs(a.lo), abs(a.hi)) ** n);
      }
    }

    // BOOLEANS

    operator ==(a : Interval, b : Interval) {
      return a.lo == b.lo && a.hi == b.hi;
    }

    operator ==(a : Interval, b : real) {
      return a.lo == b && a.hi == b;
    }

    // here I choose to represent the empty interval as [NaN, NaN]
    proc isempty {
      return isnan(this.lo) && isnan(this.hi);
    }

    // SET OPERATIONS
    proc hull(b : Interval) {
      if this.isempty then return b;
      if b.isempty then return this;
      return new Interval(min(this.lo, b.lo), max(this.hi, b.hi));
    }

    // NUMERICS
    proc mid {
      return (this.lo + this.hi)/2;
    }

    proc bisect {
      return (new Interval(this.lo, this.mid), new Interval(this.mid, this.hi));
    }
  }

  proc is_invalid_interval(lo : real, hi : real) {
    return lo > hi || lo == INFINITY || hi == -INFINITY || isnan(lo) || isnan(hi);
  }

  // ? can I do something like operator ...(lo : real, hi : real) to be able to write lo...hi for an interval?
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