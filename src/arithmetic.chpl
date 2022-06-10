module arithmetic {
    use Chimera;
    operator Interval.-(a : Interval, b : Interval) {
        return new Interval(a.lo - b.hi, a.hi - b.lo);
    }

    operator Interval.+(x, y) where isEitherInterval(x.type, y.type) {
      return new Interval(inf(x) + inf(y), sup(x) + sup(y));
    }

    operator Interval.*(a : Interval, b : Interval) {
      if a.isempty || b.isempty then return new Interval(NAN, NAN);
      if a == 0 || b == 0 then return new Interval(0, 0);
      var lolo = a.lo * b.lo,
          lohi = a.lo * b.hi,
          hilo = a.hi * b.lo,
          hihi = a.hi * b.hi;

      return new Interval(_min_no_nan(_min_no_nan(lolo, lohi), _min_no_nan(hilo, hihi)), _max_no_nan(_max_no_nan(lolo, lohi), _max_no_nan(hilo, hihi)));
    }

    proc Interval.inv {
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

    operator Interval.**(a : Interval, n : int) {
      if n % 2 then 
        return new Interval(a.lo ** n, a.hi ** n);
      else {
        if a.lo <= 0 && 0 <= a.hi then
          return new Interval(0, max(abs(a.lo), abs(a.hi)) ** n); 
        else
          return new Interval(min(abs(a.lo), abs(a.hi)) ** n, max(abs(a.lo), abs(a.hi)) ** n);
      }
    }
}