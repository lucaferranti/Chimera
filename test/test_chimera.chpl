use UnitTest;
use Chimera;

proc test_addition(test : borrowed Test) throws {
    test.assertEqual(infsup(1, 2) + infsup(2, 3), infsup(3, 5));
    test.assertTrue(infsup(1, INFINITY) + infsup(-INFINITY, 2) == infsup(-INFINITY, INFINITY));
    test.assertTrue(infsup(1, 2) + 3 == infsup(4, 5));
}

proc test_subtraction(test : borrowed Test) throws {
    test.assertTrue(infsup(1, 2) - infsup(1, 2) == infsup(-1, 1));
    test.assertTrue(isempty(infsup(1, 2) - infsup(NAN, NAN)));
}

proc test_multiplication(test : borrowed Test) throws {
    test.assertTrue(infsup(1, 2) * infsup(-2, 3) == infsup(-4, 6));
    test.assertTrue(infsup(0, 0) * infsup(-INFINITY, INFINITY) == infsup(0, 0));
    test.assertTrue(isempty(infsup(0, 0) * infsup(NAN, NAN)));
    test.assertTrue(infsup(0, INFINITY) * infsup(-INFINITY, 1) == infsup(-INFINITY, INFINITY));
    test.assertTrue(isempty(infsup(-INFINITY, INFINITY) * infsup(NAN, NAN)));
}

proc test_inv(test : borrowed Test) throws {
    var a = infsup(1, 2);
    var b = infsup(-2, -1);
    var c = infsup(0, 1);
    var d = infsup(-1, 0);
    var e = infsup(-2, 2);
    var f = infsup(NAN, NAN);

    test.assertTrue(inv(a) == infsup(0.5, 1));
    test.assertTrue(inv(b) == infsup(-1, -0.5));
    test.assertTrue(inv(c) == infsup(1, INFINITY));
    test.assertTrue(inv(d) == infsup(-INFINITY, -1));
    test.assertTrue(inv(e) == infsup(-INFINITY, INFINITY));
    test.assertTrue(isempty(inv(f)));
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
    test.assertTrue(isempty(f ** 2));
    test.assertTrue(isempty(f ** 3));
}

UnitTest.main();