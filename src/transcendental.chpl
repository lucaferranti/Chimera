module transcendental {  

  use Chimera;
  
  proc exp(a : Interval) {
    return new Interval(exp_rd(inf(a)), exp_ru(sup(a)));
  }

  proc log(a : Interval) {
    if sup(a) <= 0 then return EMPTY;
    return new Interval(log_rd(max(inf(a), 0.0)), log_ru(sup(a)));
  }

  operator **(x : Interval, y) where isIntervalOrRealType(y.type) {
    return exp(y * log(x));
  }

}