module numerics {
    use Chimera;

    pragma "no doc"
    proc inf(a : real) {return a;}

    pragma "no doc"
    proc sup(a : real) {return a;}
  
    /*
    :arg a: ``Interval`` or ``real``

    :returns: lower bound of ``a``. For real numbers, this is the number iteself.
    
    **Note:** For empty intervals, ``NAN`` is returned. For the IEEE standard compliant behavior, see ``infieee``.
    */
    proc inf(a : Interval) {return a.lo;}
    
    /*
    :arg a: ``Interval`` or ``real``

    :returns: upper bound of ``a``. For real numbers, this is the number itself.

    **Note:** For empty intervals, ``NAN`` is returned. For the IEEE standard compliant behavior, see ``supieee``.
    */
    proc sup(a : Interval) {return a.hi;}
    
    /*
    :arg a: ``Interval`` or ``real``

    :returns: midpoint of ``a``. 
    */
    proc mid(a) where isIntervalOrRealType(a.type) {
        return (inf(a) + sup(a))/2;
    }

    /*
    :arg a: ``Interval`` or ``real``
    
    :returns: width of ``a``. For unbounded or empty intervals, returns ``NAN``.
    :rtype: real
    */
    proc width(a) where isIntervalOrRealType(a.type) {
        return sup(a) - inf(a);
    }

    /*
    :arg a: ``Interval or ``real``

    :retuns: radius of ``a``. For unbounded or empty intervals, returns ``NAN``.
    :rtype: real
    */
    proc rad(a) where isIntervalOrRealType(a.type) {
        return max(sup(a) - mid(a), mid(a) - inf(a));
    }
}