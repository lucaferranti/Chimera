module arithmetic {
    use Chimera;

    operator Interval.-(a, b) where isEitherInterval(a.type, b.type) {
        return new Interval(inf(a) - sup(b), sup(a) - inf(b));
    }

    operator Interval.+(x, y) where isEitherInterval(x.type, y.type) {
      return new Interval(inf(x) + inf(y), sup(x) + sup(y));
    }

    operator Interval.*(a, b) where isEitherInterval(a.type, b.type) {
      if (a == 0 || b == 0) && !isempty(a) && !isempty(b) then return new Interval(0, 0);
      var lolo = inf(a) * inf(b),
          lohi = inf(a) * sup(b),
          hilo = sup(a) * inf(b),
          hihi = sup(a) * sup(b);

      return new Interval(_min_no_nan(_min_no_nan(lolo, lohi), _min_no_nan(hilo, hihi)), _max_no_nan(_max_no_nan(lolo, lohi), _max_no_nan(hilo, hihi)));
    }

    proc inv(a : Interval) {
      if a == 0 then return new Interval(NAN, NAN);
      
      if !a.contains(0) then
          return new Interval(1 / sup(a), 1 / inf(a));
      else if inf(a) == 0 then
          return new Interval(1 / sup(a), INFINITY);
      else if sup(a) == 0 then 
        return new Interval(-INFINITY, 1 / inf(a));
      else
        return new Interval(-INFINITY, INFINITY);
    }

    operator Interval.**(a : Interval, n : int) {
      if n % 2 then  return new Interval(inf(a) ** n, sup(a) ** n);
      else {
        if inf(a) <= 0 && 0 <= sup(a) then
          return new Interval(0, max(abs(inf(a)), abs(sup(a))) ** n); 
        else
          return new Interval(min(abs(inf(a)), abs(sup(a))) ** n, max(abs(inf(a)), abs(sup(a))) ** n);
      }
    }
}