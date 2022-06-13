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

proc test_set_operation(test : borrowed Test) throws {
    test.assertTrue(hull(infsup(1, 2), infsup(-2, -1)) == infsup(-2, 2));
    test.assertTrue(hull(infsup(-2, 2), infsup(-1, 1)) == infsup(-2, 2));
    test.assertTrue(hull(infsup(NAN, NAN), infsup(-1, 1)) == infsup(-1, 1));
    test.assertTrue(hull(infsup(-1, 1), infsup(NAN, NAN)) == infsup(-1, 1));
    test.assertTrue(isempty(hull(infsup(NAN, NAN), infsup(NAN, NAN))));

    test.assertTrue(infsup(0, 2).contains(1));
    test.assertTrue(infsup(0,2 ).contains(0));
    test.assertFalse(infsup(0, 2).contains(3));
    test.assertFalse(infsup(0, 2).contains(-1));
    test.assertFalse(emptyinterval.contains(0));
}

proc test_prevnext_float(test : borrowed Test) throws {
    test.assertEqual(nextup(0.0), 5e-324);
    test.assertEqual(nextup(1.0), 0x1.0000000000001p0);
    test.assertEqual(nextup(0x1.FFFFFFFFFFFFFp2), 0x1p3);
    test.assertEqual(nextup(0x1.FFFFFFFFFFFFFp1023), INFINITY);
    test.assertEqual(nextup(INFINITY), INFINITY);
    test.assertTrue(isnan(nextup(NAN)));
    test.assertEqual(nextup(0x1p-1020), 0x1.0000000000001p-1020);
    test.assertEqual(nextup(-0.0), 5e-324);
    test.assertEqual(nextup(-1.0), -0x1.FFFFFFFFFFFFFp-1);
    test.assertEqual(nextup(-INFINITY), -0x1.FFFFFFFFFFFFFp1023);
    test.assertEqual(nextup(-0x1p-1020), -0x1.FFFFFFFFFFFFFp-1021);

    test.assertEqual(nextdown(0.0), -5e-324);
    test.assertEqual(nextdown(1.0), 0x1.FFFFFFFFFFFFFp-1);
    test.assertEqual(nextdown(INFINITY), 0X1.FFFFFFFFFFFFFp1023);
    test.assertEqual(nextdown(0x1p-1019), 0x1.FFFFFFFFFFFFFp-1020);
    test.assertEqual(nextdown(-INFINITY), -INFINITY);
    test.assertEqual(nextdown(-0X1.FFFFFFFFFFFFFp1023), -INFINITY);
    test.assertTrue(isnan(nextdown(NAN)));

    test.assertEqual(nextout(0.0), (-5e-324, 5e-324));
    test.assertEqual(nextout(INFINITY), (0x1.FFFFFFFFFFFFFp1023, INFINITY));
    test.assertEqual(nextout(-INFINITY), (-INFINITY, -0x1.FFFFFFFFFFFFFp1023));
    test.assertTrue(isnan(nextout(NAN)[0]));
    test.assertTrue(isnan(nextout(NAN)[1]));
    test.assertEqual(nextout(0x1.FFFFFFFFFFFFFp1023), (0x1.FFFFFFFFFFFFEp1023, INFINITY));
    test.assertEqual(nextout(-0x1.FFFFFFFFFFFFFp1023), (-INFINITY, -0x1.FFFFFFFFFFFFEp1023));
    test.assertEqual(nextout(0x1.Bp-1019), (0x1.AFFFFFFFFFFFFp-1019, 0x1.B000000000001p-1019));
}

UnitTest.main();