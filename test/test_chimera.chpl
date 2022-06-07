use UnitTest;
use Chimera;

proc test_addition(test : borrowed Test) throws {
    test.assertTrue(infsup(1, 2) + infsup(2, 3) == infsup(3, 5));
    test.assertTrue(infsup(1, INFINITY) + infsup(-INFINITY, 2) == infsup(-INFINITY, INFINITY));
}

proc test_subtraction(test : borrowed Test) throws {
    test.assertTrue(infsup(1, 2) - infsup(1, 2) == infsup(-1, 1));
    test.assertTrue((infsup(1, 2) - infsup(NAN, NAN)).isempty);
}

proc test_multiplication(test : borrowed Test) throws {
    test.assertTrue(infsup(1, 2) * infsup(-2, 3) == infsup(-4, 6));
    test.assertTrue(infsup(0, 0) * infsup(-INFINITY, INFINITY) == infsup(0, 0));
    test.assertTrue((infsup(0, 0) * infsup(NAN, NAN)).isempty);
}

proc test_inv(test : borrowed Test) throws {
    var a = infsup(1, 2);
    var b = infsup(-2, -1);
    var c = infsup(0, 1);
    var d = infsup(-1, 0);
    var e = infsup(-2, 2);
    var f = infsup(NAN, NAN);

    test.assertTrue(a.inv == infsup(0.5, 1));
    test.assertTrue(b.inv == infsup(-1, -0.5));
    test.assertTrue(c.inv == infsup(1, INFINITY));
    test.assertTrue(d.inv == infsup(-INFINITY, -1));
    test.assertTrue(e.inv == infsup(-INFINITY, INFINITY));
    test.assertTrue(f.inv.isempty);
}

proc test_pow(test : borrowed Test) throws {
    var a = infsup(1, 2);
    var b = infsup(-2, -1);
    var c = infsup(0, 1);
    var d = infsup(-1, 0);
    var e = infsup(-2, 3);
    var f = infsup(NAN, NAN);

    test.assertTrue(a ** 2 == infsup(1, 4));
    test.assertTrue(a ** 3 == infsup(1, 8));
    test.assertTrue(b ** 2 == infsup(1, 4));
    test.assertTrue(b ** 3 == infsup(-8, -1));
    test.assertTrue(c ** 2 == infsup(0, 1));
    test.assertTrue(d ** 2 == infsup(0, 1));
    test.assertTrue(e ** 2 == infsup(0, 9));
    test.assertTrue(e ** 3 == infsup(-8, 27));
    test.assertTrue((f ** 2).isempty);
    test.assertTrue((f ** 3).isempty);
}

proc test_set_operation(test : borrowed Test) throws {
    test.assertTrue(infsup(1, 2).hull(infsup(-2, -1)) == infsup(-2, 2));
    test.assertTrue(infsup(-2, 2).hull(infsup(-1, 1)) == infsup(-2, 2));
    test.assertTrue(infsup(NAN, NAN).hull(infsup(-1, 1)) == infsup(-1, 1));
    test.assertTrue(infsup(-1, 1).hull(infsup(NAN, NAN)) == infsup(-1, 1));
    test.assertTrue(infsup(NAN, NAN).hull(infsup(NAN, NAN)).isempty);
}

UnitTest.main();