module transcendental {  

  use crlibm;
  use Chimera;
  proc exp(a : Interval) {
    return new Interval(exp_rd(a.lo), exp_ru(a.hi));
  }

}