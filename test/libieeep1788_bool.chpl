/*
* 
* Unit tests from libieeep1788 for interval boolean operations
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

proc minimal_is_empty_test(test : borrowed Test) throws {
    test.assertTrue(isempty(EMPTY));
    test.assertEqual(isempty(infsup(-INFINITY, INFINITY)), false);
    test.assertEqual(isempty(infsup(1.0, 2.0)), false);
    test.assertEqual(isempty(infsup(-1.0, 2.0)), false);
    test.assertEqual(isempty(infsup(-3.0, -2.0)), false);
    test.assertEqual(isempty(infsup(-INFINITY, 2.0)), false);
    test.assertEqual(isempty(infsup(-INFINITY, 0.0)), false);
    test.assertEqual(isempty(infsup(-INFINITY, -0.0)), false);
    test.assertEqual(isempty(infsup(0.0, INFINITY)), false);
    test.assertEqual(isempty(infsup(-0.0, INFINITY)), false);
    test.assertEqual(isempty(infsup(-0.0, 0.0)), false);
    test.assertEqual(isempty(infsup(0.0, -0.0)), false);
    test.assertEqual(isempty(infsup(0.0, 0.0)), false);
    test.assertEqual(isempty(infsup(-0.0, -0.0)), false);
}

proc minimal_is_entire_test(test : borrowed Test) throws {
    test.assertEqual(isentire(EMPTY), false);
    test.assertTrue(isentire(infsup(-INFINITY, INFINITY)));
    test.assertEqual(isentire(infsup(1.0, 2.0)), false);
    test.assertEqual(isentire(infsup(-1.0, 2.0)), false);
    test.assertEqual(isentire(infsup(-3.0, -2.0)), false);
    test.assertEqual(isentire(infsup(-INFINITY, 2.0)), false);
    test.assertEqual(isentire(infsup(-INFINITY, 0.0)), false);
    test.assertEqual(isentire(infsup(-INFINITY, -0.0)), false);
    test.assertEqual(isentire(infsup(0.0, INFINITY)), false);
    test.assertEqual(isentire(infsup(-0.0, INFINITY)), false);
    test.assertEqual(isentire(infsup(-0.0, 0.0)), false);
    test.assertEqual(isentire(infsup(0.0, -0.0)), false);
    test.assertEqual(isentire(infsup(0.0, 0.0)), false);
    test.assertEqual(isentire(infsup(-0.0, -0.0)), false);
}

proc minimal_equal_test(test : borrowed Test) throws {
    test.assertTrue(infsup(1.0, 2.0) == infsup(1.0, 2.0));
    test.assertEqual(infsup(1.0, 2.1) == infsup(1.0, 2.0), false);
    test.assertTrue(EMPTY == EMPTY);
    test.assertEqual(EMPTY == infsup(1.0, 2.0), false);
    test.assertTrue(infsup(-INFINITY, INFINITY) == infsup(-INFINITY, INFINITY));
    test.assertEqual(infsup(1.0, 2.4) == infsup(-INFINITY, INFINITY), false);
    test.assertTrue(infsup(1.0, INFINITY) == infsup(1.0, INFINITY));
    test.assertEqual(infsup(1.0, 2.4) == infsup(1.0, INFINITY), false);
    test.assertTrue(infsup(-INFINITY, 2.0) == infsup(-INFINITY, 2.0));
    test.assertEqual(infsup(-INFINITY, 2.4) == infsup(-INFINITY, 2.0), false);
    test.assertTrue(infsup(-2.0, 0.0) == infsup(-2.0, 0.0));
    test.assertTrue(infsup(-0.0, 2.0) == infsup(0.0, 2.0));
    test.assertTrue(infsup(-0.0, -0.0) == infsup(0.0, 0.0));
    test.assertTrue(infsup(-0.0, 0.0) == infsup(0.0, 0.0));
    test.assertTrue(infsup(0.0, -0.0) == infsup(0.0, 0.0));
}

proc minimal_subset_test(test : borrowed Test) throws {
    test.assertTrue(EMPTY.contains(EMPTY));
    test.assertTrue(infsup(0.0, 4.0).contains(EMPTY));
    test.assertTrue(infsup(-0.0, 4.0).contains(EMPTY));
    test.assertTrue(infsup(-0.1, 1.0).contains(EMPTY));
    test.assertTrue(infsup(-0.1, 0.0).contains(EMPTY));
    test.assertTrue(infsup(-0.1, -0.0).contains(EMPTY));
    test.assertTrue(infsup(-INFINITY, INFINITY).contains(EMPTY));
    test.assertEqual(EMPTY.contains(infsup(0.0, 4.0)), false);
    test.assertEqual(EMPTY.contains(infsup(-0.0, 4.0)), false);
    test.assertEqual(EMPTY.contains(infsup(-0.1, 1.0)), false);
    test.assertEqual(EMPTY.contains(infsup(-INFINITY, INFINITY)), false);
    test.assertTrue(infsup(-INFINITY, INFINITY).contains(infsup(0.0, 4.0)));
    test.assertTrue(infsup(-INFINITY, INFINITY).contains(infsup(-0.0, 4.0)));
    test.assertTrue(infsup(-INFINITY, INFINITY).contains(infsup(-0.1, 1.0)));
    test.assertTrue(infsup(-INFINITY, INFINITY).contains(infsup(-INFINITY, INFINITY)));
    test.assertTrue(infsup(1.0, 2.0).contains(infsup(1.0, 2.0)));
    test.assertTrue(infsup(0.0, 4.0).contains(infsup(1.0, 2.0)));
    test.assertTrue(infsup(-0.0, 4.0).contains(infsup(1.0, 2.0)));
    test.assertTrue(infsup(0.0, 4.0).contains(infsup(0.1, 0.2)));
    test.assertTrue(infsup(-0.0, 4.0).contains(infsup(0.1, 0.2)));
    test.assertTrue(infsup(-4.0, 3.4).contains(infsup(-0.1, -0.1)));
    test.assertTrue(infsup(-0.0, -0.0).contains(infsup(0.0, 0.0)));
    test.assertTrue(infsup(0.0, 0.0).contains(infsup(-0.0, -0.0)));
    test.assertTrue(infsup(0.0, 0.0).contains(infsup(-0.0, 0.0)));
    test.assertTrue(infsup(0.0, -0.0).contains(infsup(-0.0, 0.0)));
    test.assertTrue(infsup(0.0, 0.0).contains(infsup(0.0, -0.0)));
    test.assertTrue(infsup(-0.0, 0.0).contains(infsup(0.0, -0.0)));
}

proc minimal_less_test(test : borrowed Test) throws {
    test.assertTrue(EMPTY <= EMPTY);
    test.assertEqual(infsup(1.0, 2.0) <= EMPTY, false);
    test.assertEqual(EMPTY <= infsup(1.0, 2.0), false);
    test.assertTrue(infsup(-INFINITY, INFINITY) <= infsup(-INFINITY, INFINITY));
    test.assertEqual(infsup(1.0, 2.0) <= infsup(-INFINITY, INFINITY), false);
    test.assertEqual(infsup(0.0, 2.0) <= infsup(-INFINITY, INFINITY), false);
    test.assertEqual(infsup(-0.0, 2.0) <= infsup(-INFINITY, INFINITY), false);
    test.assertEqual(infsup(-INFINITY, INFINITY) <= infsup(1.0, 2.0), false);
    test.assertEqual(infsup(-INFINITY, INFINITY) <= infsup(0.0, 2.0), false);
    test.assertEqual(infsup(-INFINITY, INFINITY) <= infsup(-0.0, 2.0), false);
    test.assertTrue(infsup(0.0, 2.0) <= infsup(0.0, 2.0));
    test.assertTrue(infsup(0.0, 2.0) <= infsup(-0.0, 2.0));
    test.assertTrue(infsup(0.0, 2.0) <= infsup(1.0, 2.0));
    test.assertTrue(infsup(-0.0, 2.0) <= infsup(1.0, 2.0));
    test.assertTrue(infsup(1.0, 2.0) <= infsup(1.0, 2.0));
    test.assertTrue(infsup(1.0, 2.0) <= infsup(3.0, 4.0));
    test.assertTrue(infsup(1.0, 3.5) <= infsup(3.0, 4.0));
    test.assertTrue(infsup(1.0, 4.0) <= infsup(3.0, 4.0));
    test.assertTrue(infsup(-2.0, -1.0) <= infsup(-2.0, -1.0));
    test.assertTrue(infsup(-3.0, -1.5) <= infsup(-2.0, -1.0));
    test.assertTrue(infsup(0.0, 0.0) <= infsup(-0.0, -0.0));
    test.assertTrue(infsup(-0.0, -0.0) <= infsup(0.0, 0.0));
    test.assertTrue(infsup(-0.0, 0.0) <= infsup(0.0, 0.0));
    test.assertTrue(infsup(-0.0, 0.0) <= infsup(0.0, -0.0));
    test.assertTrue(infsup(0.0, -0.0) <= infsup(0.0, 0.0));
    test.assertTrue(infsup(0.0, -0.0) <= infsup(-0.0, 0.0));
}

proc minimal_precedes_test(test : borrowed Test) throws {
    test.assertTrue(precedes(EMPTY, infsup(3.0, 4.0)));
    test.assertTrue(precedes(infsup(3.0, 4.0), EMPTY));
    test.assertTrue(precedes(EMPTY, EMPTY));
    test.assertEqual(precedes(infsup(1.0, 2.0), infsup(-INFINITY, INFINITY)), false);
    test.assertEqual(precedes(infsup(0.0, 2.0), infsup(-INFINITY, INFINITY)), false);
    test.assertEqual(precedes(infsup(-0.0, 2.0), infsup(-INFINITY, INFINITY)), false);
    test.assertEqual(precedes(infsup(-INFINITY, INFINITY), infsup(1.0, 2.0)), false);
    test.assertEqual(precedes(infsup(-INFINITY, INFINITY), infsup(-INFINITY, INFINITY)), false);
    test.assertTrue(precedes(infsup(1.0, 2.0), infsup(3.0, 4.0)));
    test.assertTrue(precedes(infsup(1.0, 3.0), infsup(3.0, 4.0)));
    test.assertTrue(precedes(infsup(-3.0, -1.0), infsup(-1.0, 0.0)));
    test.assertTrue(precedes(infsup(-3.0, -1.0), infsup(-1.0, -0.0)));
    test.assertEqual(precedes(infsup(1.0, 3.5), infsup(3.0, 4.0)), false);
    test.assertEqual(precedes(infsup(1.0, 4.0), infsup(3.0, 4.0)), false);
    test.assertEqual(precedes(infsup(-3.0, -0.1), infsup(-1.0, 0.0)), false);
    test.assertTrue(precedes(infsup(0.0, 0.0), infsup(-0.0, -0.0)));
    test.assertTrue(precedes(infsup(-0.0, -0.0), infsup(0.0, 0.0)));
    test.assertTrue(precedes(infsup(-0.0, 0.0), infsup(0.0, 0.0)));
    test.assertTrue(precedes(infsup(-0.0, 0.0), infsup(0.0, -0.0)));
    test.assertTrue(precedes(infsup(0.0, -0.0), infsup(0.0, 0.0)));
    test.assertTrue(precedes(infsup(0.0, -0.0), infsup(-0.0, 0.0)));
}

proc minimal_interior_test(test : borrowed Test) throws {
    test.assertTrue(isinterior(EMPTY, EMPTY));
    test.assertTrue(isinterior(EMPTY, infsup(0.0, 4.0)));
    test.assertEqual(isinterior(infsup(0.0, 4.0), EMPTY), false);
    test.assertTrue(isinterior(infsup(-INFINITY, INFINITY), infsup(-INFINITY, INFINITY)));
    test.assertTrue(isinterior(infsup(0.0, 4.0), infsup(-INFINITY, INFINITY)));
    test.assertTrue(isinterior(EMPTY, infsup(-INFINITY, INFINITY)));
    test.assertEqual(isinterior(infsup(-INFINITY, INFINITY), infsup(0.0, 4.0)), false);
    test.assertEqual(isinterior(infsup(0.0, 4.0), infsup(0.0, 4.0)), false);
    test.assertTrue(isinterior(infsup(1.0, 2.0), infsup(0.0, 4.0)));
    test.assertEqual(isinterior(infsup(-2.0, 2.0), infsup(-2.0, 4.0)), false);
    test.assertTrue(isinterior(infsup(-0.0, -0.0), infsup(-2.0, 4.0)));
    test.assertTrue(isinterior(infsup(0.0, 0.0), infsup(-2.0, 4.0)));
    test.assertEqual(isinterior(infsup(0.0, 0.0), infsup(-0.0, -0.0)), false);
    test.assertEqual(isinterior(infsup(0.0, 4.4), infsup(0.0, 4.0)), false);
    test.assertEqual(isinterior(infsup(-1.0, -1.0), infsup(0.0, 4.0)), false);
    test.assertEqual(isinterior(infsup(2.0, 2.0), infsup(-2.0, -1.0)), false);
}

proc minimal_strictly_less_test(test : borrowed Test) throws {
    test.assertTrue(EMPTY < EMPTY);
    test.assertEqual(infsup(1.0, 2.0) < EMPTY, false);
    test.assertEqual(EMPTY < infsup(1.0, 2.0), false);
    test.assertTrue(infsup(-INFINITY, INFINITY) < infsup(-INFINITY, INFINITY));
    test.assertEqual(infsup(1.0, 2.0) < infsup(-INFINITY, INFINITY), false);
    test.assertEqual(infsup(-INFINITY, INFINITY) < infsup(1.0, 2.0), false);
    test.assertEqual(infsup(1.0, 2.0) < infsup(1.0, 2.0), false);
    test.assertTrue(infsup(1.0, 2.0) < infsup(3.0, 4.0));
    test.assertTrue(infsup(1.0, 3.5) < infsup(3.0, 4.0));
    test.assertEqual(infsup(1.0, 4.0) < infsup(3.0, 4.0), false);
    test.assertEqual(infsup(0.0, 4.0) < infsup(0.0, 4.0), false);
    test.assertEqual(infsup(-0.0, 4.0) < infsup(0.0, 4.0), false);
    test.assertEqual(infsup(-2.0, -1.0) < infsup(-2.0, -1.0), false);
    test.assertTrue(infsup(-3.0, -1.5) < infsup(-2.0, -1.0));
}

proc minimal_strictly_precedes_test(test : borrowed Test) throws {
    test.assertTrue(strictprecedes(EMPTY, infsup(3.0, 4.0)));
    test.assertTrue(strictprecedes(infsup(3.0, 4.0), EMPTY));
    test.assertTrue(strictprecedes(EMPTY, EMPTY));
    test.assertEqual(strictprecedes(infsup(1.0, 2.0), infsup(-INFINITY, INFINITY)), false);
    test.assertEqual(strictprecedes(infsup(-INFINITY, INFINITY), infsup(1.0, 2.0)), false);
    test.assertEqual(strictprecedes(infsup(-INFINITY, INFINITY), infsup(-INFINITY, INFINITY)), false);
    test.assertTrue(strictprecedes(infsup(1.0, 2.0), infsup(3.0, 4.0)));
    test.assertEqual(strictprecedes(infsup(1.0, 3.0), infsup(3.0, 4.0)), false);
    test.assertEqual(strictprecedes(infsup(-3.0, -1.0), infsup(-1.0, 0.0)), false);
    test.assertEqual(strictprecedes(infsup(-3.0, -0.0), infsup(0.0, 1.0)), false);
    test.assertEqual(strictprecedes(infsup(-3.0, 0.0), infsup(-0.0, 1.0)), false);
    test.assertEqual(strictprecedes(infsup(1.0, 3.5), infsup(3.0, 4.0)), false);
    test.assertEqual(strictprecedes(infsup(1.0, 4.0), infsup(3.0, 4.0)), false);
    test.assertEqual(strictprecedes(infsup(-3.0, -0.1), infsup(-1.0, 0.0)), false);
}

proc minimal_disjoint_test(test : borrowed Test) throws {
    test.assertTrue(isdisjoint(EMPTY, infsup(3.0, 4.0)));
    test.assertTrue(isdisjoint(infsup(3.0, 4.0), EMPTY));
    test.assertTrue(isdisjoint(EMPTY, EMPTY));
    test.assertTrue(isdisjoint(infsup(3.0, 4.0), infsup(1.0, 2.0)));
    test.assertEqual(isdisjoint(infsup(0.0, 0.0), infsup(-0.0, -0.0)), false);
    test.assertEqual(isdisjoint(infsup(0.0, -0.0), infsup(-0.0, 0.0)), false);
    test.assertEqual(isdisjoint(infsup(3.0, 4.0), infsup(1.0, 7.0)), false);
    test.assertEqual(isdisjoint(infsup(3.0, 4.0), infsup(-INFINITY, INFINITY)), false);
    test.assertEqual(isdisjoint(infsup(-INFINITY, INFINITY), infsup(1.0, 7.0)), false);
    test.assertEqual(isdisjoint(infsup(-INFINITY, INFINITY), infsup(-INFINITY, INFINITY)), false);
}

UnitTest.main();
