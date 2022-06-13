/*
* 
* Unit tests from libieeep1788 for recommended interval boolean operations
* (Original author: Marco Nehmeier)
* converted into portable ITL format by Oliver Heimlich.
* 
* Copyright 2013-2015 Marco Nehmeier (nehmeier@informatik.uni-wuerzburg.de)
* Copyright 2015-2017 Oliver Heimlich (oheim@posteo.de)
* 
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
* 
*     http://www.apache.org/licenses/LICENSE-2.0
* 
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
* 
*/
//Language imports

//Test library imports
use UnitTest;

//Arithmetic library imports
use Chimera;

//Preamble

proc minimal_is_common_interval_test(test : borrowed Test) throws {
    test.assertTrue(iscommon(infsup(-27.0, -27.0)));
    test.assertTrue(iscommon(infsup(-27.0, 0.0)));
    test.assertTrue(iscommon(infsup(0.0, 0.0)));
    test.assertTrue(iscommon(infsup(-0.0, -0.0)));
    test.assertTrue(iscommon(infsup(-0.0, 0.0)));
    test.assertTrue(iscommon(infsup(0.0, -0.0)));
    test.assertTrue(iscommon(infsup(5.0, 12.4)));
    test.assertTrue(iscommon(infsup(-0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023)));
    test.assertEqual(iscommon(ENTIRE), false);
    test.assertEqual(iscommon(EMPTY), false);
    test.assertEqual(iscommon(infsup(-INFINITY, 0.0)), false);
    test.assertEqual(iscommon(infsup(0.0, INFINITY)), false);
}

proc minimal_is_singleton_test(test : borrowed Test) throws {
    test.assertTrue(issingleton(infsup(-27.0, -27.0)));
    test.assertTrue(issingleton(infsup(-2.0, -2.0)));
    test.assertTrue(issingleton(infsup(12.0, 12.0)));
    test.assertTrue(issingleton(infsup(17.1, 17.1)));
    test.assertTrue(issingleton(infsup(-0.0, -0.0)));
    test.assertTrue(issingleton(infsup(0.0, 0.0)));
    test.assertTrue(issingleton(infsup(-0.0, 0.0)));
    test.assertTrue(issingleton(infsup(0.0, -0.0)));
    test.assertEqual(issingleton(EMPTY), false);
    test.assertEqual(issingleton(ENTIRE), false);
    test.assertEqual(issingleton(infsup(-1.0, 0.0)), false);
    test.assertEqual(issingleton(infsup(-1.0, -0.5)), false);
    test.assertEqual(issingleton(infsup(1.0, 2.0)), false);
    test.assertEqual(issingleton(infsup(-INFINITY, -0x1.FFFFFFFFFFFFFp1023)), false);
    test.assertEqual(issingleton(infsup(-1.0, INFINITY)), false);
}

proc minimal_is_member_test(test : borrowed Test) throws {
    test.assertTrue(infsup(-27.0, -27.0).contains(-27.0));
    test.assertTrue(infsup(-27.0, 0.0).contains(-27.0));
    test.assertTrue(infsup(-27.0, 0.0).contains(-7.0));
    test.assertTrue(infsup(-27.0, 0.0).contains(0.0));
    test.assertTrue(infsup(0.0, 0.0).contains(-0.0));
    test.assertTrue(infsup(0.0, 0.0).contains(0.0));
    test.assertTrue(infsup(-0.0, -0.0).contains(0.0));
    test.assertTrue(infsup(-0.0, 0.0).contains(0.0));
    test.assertTrue(infsup(0.0, -0.0).contains(0.0));
    test.assertTrue(infsup(5.0, 12.4).contains(5.0));
    test.assertTrue(infsup(5.0, 12.4).contains(6.3));
    test.assertTrue(infsup(5.0, 12.4).contains(12.4));
    test.assertTrue(ENTIRE.contains(0.0));
    test.assertTrue(ENTIRE.contains(5.0));
    test.assertTrue(ENTIRE.contains(6.3));
    test.assertTrue(ENTIRE.contains(12.4));
    test.assertTrue(ENTIRE.contains(0x1.FFFFFFFFFFFFFp1023));
    test.assertTrue(ENTIRE.contains(-0x1.FFFFFFFFFFFFFp1023));
    test.assertTrue(ENTIRE.contains(0x1.0p-1022));
    test.assertTrue(ENTIRE.contains(-0x1.0p-1022));
    test.assertEqual(infsup(-27.0, 0.0).contains(-71.0), false);
    test.assertEqual(infsup(-27.0, 0.0).contains(0.1), false);
    test.assertEqual(infsup(0.0, 0.0).contains(-0.01), false);
    test.assertEqual(infsup(0.0, 0.0).contains(0.000001), false);
    test.assertEqual(infsup(-0.0, -0.0).contains(111110.0), false);
    test.assertEqual(infsup(5.0, 12.4).contains(4.9), false);
    test.assertEqual(infsup(5.0, 12.4).contains(-6.3), false);
    test.assertEqual(EMPTY.contains(0.0), false);
    test.assertEqual(EMPTY.contains(-4535.3), false);
    test.assertEqual(EMPTY.contains(-INFINITY), false);
    test.assertEqual(EMPTY.contains(INFINITY), false);
    test.assertEqual(EMPTY.contains(NAN), false);
    test.assertEqual(ENTIRE.contains(-INFINITY), false);
    test.assertEqual(ENTIRE.contains(INFINITY), false);
    test.assertEqual(ENTIRE.contains(NAN), false);
}

UnitTest.main();
