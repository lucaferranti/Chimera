module transcendental {  

  use crlibm;
  use Chimera;
  proc exp(a : Interval) {
    return new Interval(exp_rd(inf(a)), exp_ru(sup(a)));
  }

}