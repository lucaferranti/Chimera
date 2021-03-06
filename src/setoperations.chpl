module setoperations {
    use Chimera;

    /*
        :arg a:
        :arg b:
        :type a: Interval or real
        :type b: Interval or real

        :returns: hull of ``a`` and ``b``
    */
    proc hull(a, b) where isEitherInterval(a.type, b.type) {
        if isempty(a) then return b;
        if isempty(b) then return a;
        return new Interval(_min_no_nan(inf(a), inf(b)), _max_no_nan(sup(a), sup(b)));
    }

    /*
    :arg a:
    :arg b:
    :type a: Interval or real
    :type b: Interval or real

    :returns: intersection of ``a`` and ``b``
    */
    proc intersect(a, b) where isEitherInterval(a.type, b.type) {
        var tmp = new Interval(max(inf(a), inf(b)), min(sup(a), sup(b)));
        if sup(tmp) < inf(tmp) then return new Interval(NAN, NAN);
        return tmp;
    }
}