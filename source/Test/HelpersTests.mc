using Toybox.Test;
using Toybox.Math;

(:test)
function testMin(logger) {
    Test.assert(5 == min(5, 10));
    Test.assert(0.17 == min(0.17, 0.18));
    return true;
}

(:test)
function testMax(logger) {
    Test.assert(10 == max(5, 10));
    Test.assert(0.18 == max(0.17, 0.18));
    return true;
}

(:test)
function testAbs(logger) {
    Test.assert(1.45 == abs(-1.45));
    Test.assert(1.45 == abs(1.45));
    return true;
}

// (:test)
// function testShuffledArray(logger) {
//     var input = [1, 2, 3];
//     var output = shuffleArray(input);
//     logger.debug("The new array is " + output);
//     Test.assert(input.toString() != output.toString());
//     Test.assertEqual(input.size(), output.size());
//     return true;
// }
