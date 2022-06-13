use UnitTest;
use Chimera;

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