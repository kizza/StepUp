using Toybox.Lang;
using Toybox.Test;
using Toybox.Math;

(:test)
function testMirrorAngle(logger) {
    assertMirrorAngle(0, 0);
    assertMirrorAngle(10, 350);
    assertMirrorAngle(45, 315);
    assertMirrorAngle(90, 270);
    assertMirrorAngle(180, 180);
    assertMirrorAngle(270, 90);
    assertMirrorAngle(-90, 270);
    assertMirrorAngle(-170, 190);
    return true;
}

function assertMirrorAngle(input, expected) {
    var result = mirrorAngle(input);
    Test.assertEqualMessage(result, expected, "Expected mirrorAngle("+ input +") to equal "+ expected +" but was "+ result);
}

(:test)
function testMapAngle(logger) {
    assertMapAngle(45, 45);
    assertMapAngle(90, 0);
    assertMapAngle(135, 315);
    assertMapAngle(170, 280);
    assertMapAngle(180, 270);
    assertMapAngle(190, 260);
    assertMapAngle(270, 180);
    assertMapAngle(315, 135);
    return true;
}

function assertMapAngle(input, expected) {
    var result = mapAngle(input);
    Test.assertEqualMessage(result, expected, "Expected mapAngle("+ input +") to equal "+ expected +" but was "+ result);
}

(:test)
function testOffsetFromCenter(logger) {
    assertOffsetFromCenter(100, 0, [120, 20]);
    assertOffsetFromCenter(10, 90, [130, 120]);
    assertOffsetFromCenter(50, 180, [120, 170]);
    assertOffsetFromCenter(50, 270, [70, 120]);
    return true;
}

function assertOffsetFromCenter(offset, angle, expected) {
    var result = offsetFromCenter(offset, angle);
    Test.assertMessage(
		result[0] == expected[0] && result[1] == expected[1],
		Lang.format("Expected offsetFromCenter($1$, $2$) to equal $3$ but was $4$",
			[offset, angle, expected, result]
		)
	);
}

(:test)
function testMapArcDegreesWithoutRotation(logger) {
	// Weirdly in the api
	// 0 degrees: 3 o'clock position, 90 degrees: 12 o'clock position,
	// 180 degrees: 9 o'clock position, 270 degrees: 6 o'clock position.

	// 12 onward (no rotation)
    assertMapArcDegrees(0, 90, 0, [90, 0]);
    assertMapArcDegrees(0, 180, 0, [90, 270]);
    assertMapArcDegrees(0, 270, 0, [90, 180]);

	// 3 onward (no rotation)
    assertMapArcDegrees(90, 90, 0, [0, 0]);
    assertMapArcDegrees(90, 180, 0, [0, 270]);
    assertMapArcDegrees(90, 270, 0, [0, 180]);

	// Bottom 90 degree arc
    assertMapArcDegrees(90+45, 180+45, 0, [315, 225]);
    return true;
}

(:test)
function testMapArcDegreesWithRotation(logger) {
    assertMapArcDegrees(0, 90, 90, [0, -90]);
    assertMapArcDegrees(0, 90, -90, [180, 90]);
    assertMapArcDegrees(0, 90, -120, [210, 120]);
    return true;
}

function assertMapArcDegrees(start, end, rotation, expected) {
    var result = mapArcDegrees(start, end, rotation);
    Test.assertMessage(
		result[0] == expected[0] && result[1] == expected[1],
		Lang.format("Expected mapArcDegrees($1$, $2$, $3$) to equal $4$ but was $5$",
			[start, end, rotation, expected, result]
		)
	);
}
