
module boolean {
    use Chimera;

    /*
    :arg a: ``Interval``
    :arg b: ``Interval``

    :returns: ``true`` if ``a`` and ``b`` are the same interval.
    */
    operator ==(a, b) where isEitherInterval(a.type, b.type) {
      if isempty(a) then return isempty(b);
      return inf(a) == inf(b) && sup(a) == sup(b);
    }

    /*
    :arg a: ``Interval``
    :arg b: ``Interval``

    :returns: ``true`` if ``inf(a) <= inf(b) && sup(a) <= sup(b)``
    */
    operator <=(a, b) where isEitherInterval(a.type, b.type) {
      if isempty(a) then return isempty(b);
      return inf(a) <= inf(b) && sup(a) <= sup(b);
    }

    /*
    Computes a < b with the convention that Inf < Inf is true
    */
    pragma "no doc"
    proc _isless(a : real, b : real) {
      if isfinite(a) then return a < b;
      return a <= b;
    }

    /*
    :arg a: ``Interval`` or ``real``
    :arg b: ``Interval`` or ``real``

    :returns: ``true`` if ``inf(a) < inf(b) && sup(a) < sup(b)``, interpreting ``Inf < Inf`` as ``true``
    */
    operator <(a, b) where isEitherInterval(a.type, b.type) {
      if isempty(a) then return isempty(b);
      return _isless(inf(a), inf(b)) && _isless(sup(a), sup(b));
    }

    /*
    :arg a: ``Interval`` or ``real``
    :arg b: ``Interval`` or ``real``

    :returns: ``true`` if ``a`` is before ``b``, that is ``sup(a) <= inf(b)``, or if either interval is empty.
    */
    proc  precedes(a, b) where isEitherInterval(a.type, b.type) {
      if isempty(a) || isempty(b) then return true;
      return sup(a) <= inf(b);
    }

    /*
    :arg a: ``Interval`` or ``real``
    :arg b: ``Interval`` or ``real``

    :returns: ``true`` if ``a`` is strictly before ``b``, that is ``sup(a) < inf(b)``, or if either interval is empty.
    */
    proc strictprecedes(a, b) where isEitherInterval(a.type, b.type) {
      if isempty(a) || isempty(b) then return true;
      return sup(a) < inf(b);
    }

    /*
    :arg a: ``Interval`` or ``real``
    :arg b: ``Interval`` or ``real``

    :returns: ``true`` if ``a`` and ``b`` are disjoint or if either interval is empty.
    */
    proc isdisjoint(a, b) where isEitherInterval(a.type, b.type) {
      if isempty(a) || isempty(b) then return true;
      return sup(a) < inf(b) || inf(a) > sup(b);
    }

    /*
    :arg a: ``Interval`` or ``real``
    :arg b: ``Interval`` or ``real``

    :returns: ``true`` if ``b`` is in the interior of ``a``. That is, ``b`` is a subset of ``a`` and the intervals don't have common endpoints. 
    */
    proc isinterior(a, b) where isEitherInterval(a.type, b.type) {
      if isempty(a) then return true;
      return _isless(inf(b), inf(a)) && _isless(sup(a), sup(b));
    }

    /*
    :arg a: ``Interval`` or ``real``

    :returns: ``true`` if ``a`` is a subset/element of the interval calling the method
    */
    proc Interval.contains(a : Interval){
        if isempty(a) then return true;
        return inf(this) <= inf(a) && sup(a) <= sup(this);
    }

    pragma "no doc"
    proc Interval.contains(a : real) {
      if isfinite(a) then return inf(this) <= a && a <= sup(this);
      return false;
    }

    /*
    :arg a: ``Interval``

    :returns: ``true`` if ``a`` is the empty interval.
    */
    proc isempty(a : Interval) {
      return isnan(inf(a)) && isnan(sup(a));
    }

    pragma "no doc"
    proc isempty(a : real) {return false;}

    /*
    :arg a: ``Interval``

    :returns: ``true`` if the interval ``a`` is the whole real line.
    */
    proc isentire(a) where isIntervalOrRealType(a.type) {
      return inf(a) == -INFINITY && sup(a) == INFINITY;
    }

    /*
    :arg a: ``Interval``

    :returns: ``true`` if the interval ``a`` contains only one real number.
    */
    proc issingleton(a) where isIntervalOrRealType(a.type) {
      return inf(a) == sup(a);
    }

    /*
    :arg a: ``Interval``

    :returns: ``true`` if the interval ``a`` is bounded and non-empty.
    */
    proc iscommon(a) where isIntervalOrRealType(a.type) {
      return isfinite(inf(a)) && isfinite(sup(a));
    }


}