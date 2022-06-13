/* Documentation for chimera */
module Chimera {
  use IO;

  record Interval {
    var lo : real;
    var hi : real;

    proc readWriteThis(f) throws {
      if isnan(lo) || isnan(hi) then
          f <~> new ioLiteral("[Empty]");
      else
          f <~> new ioLiteral("[") <~> lo <~> new ioLiteral(", ") <~> hi <~> new ioLiteral("]");
    }
  }

  proc EMPTY {return new Interval(NAN, NAN);}
  proc ENTIRE {return new Interval(-INFINITY, INFINITY);}
  
  proc isIntervalType(type t: Interval) param { return true; }
  proc isIntervalType(type t) param { return false; }
  proc isIntervalOrRealType(type t) param {return isIntervalType(t) || isNumericType(t);}
  proc isEitherInterval(type t, type s) param { return isIntervalType(t) || isIntervalType(s); }

  public use arithmetic;
  public use boolean;
  public use numerics;
  public use setoperations;
  public use transcendental;
  public use utils;

  proc bisect(a) where isIntervalOrRealType(a.type) {
    return (new Interval(inf(a), mid(a)), new Interval(mid(a), sup(a)));
  }

  proc is_invalid_interval(lo : real, hi : real) {
    return lo > hi || lo == INFINITY || hi == -INFINITY || isnan(lo) || isnan(hi);
  }

  proc is_invalid_interval(lo : real) {
    return lo == INFINITY || lo == -INFINITY || isnan(lo);
  }

  proc infsup(lo : real, hi : real) {
    if is_invalid_interval(lo, hi) then
      return new Interval(NAN, NAN);
    else
      return new Interval(lo, hi);
  }

  proc infsup(lo : real) {
    if is_invalid_interval(lo) then return new Interval(NAN, NAN);
    else return new Interval(lo, lo);
  }

}
