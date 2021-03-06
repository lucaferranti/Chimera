/*
* 
* Unit tests from libieeep1788 for interval set operations
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

proc minimal_intersection_test(test : borrowed Test) throws {
    test.assertEqual(intersect(infsup(1.0, 3.0), infsup(2.1, 4.0)), infsup(2.1, 3.0));
    test.assertEqual(intersect(infsup(1.0, 3.0), infsup(3.0, 4.0)), infsup(3.0, 3.0));
    test.assertTrue(isempty(intersect(infsup(1.0, 3.0), EMPTY)));
    test.assertTrue(isempty(intersect(ENTIRE, EMPTY)));
    test.assertEqual(intersect(infsup(1.0, 3.0), ENTIRE), infsup(1.0, 3.0));
}

proc minimal_convex_hull_test(test : borrowed Test) throws {
    test.assertEqual(hull(infsup(1.0, 3.0), infsup(2.1, 4.0)), infsup(1.0, 4.0));
    test.assertEqual(hull(infsup(1.0, 1.0), infsup(2.1, 4.0)), infsup(1.0, 4.0));
    test.assertEqual(hull(infsup(1.0, 3.0), EMPTY), infsup(1.0, 3.0));
    test.assertTrue(isempty(hull(EMPTY, EMPTY)));
    test.assertEqual(hull(infsup(1.0, 3.0), ENTIRE), ENTIRE);
}

UnitTest.main();