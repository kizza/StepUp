using Toybox.Graphics as Gfx;
using Toybox.Math;
using Toybox.System;

function mirrorAngle(angle) {
    if (angle < 0) {
        return mirrorAngle(abs(angle));
    }

    var result = 360 - angle;
    if (result >= 360) {
        return result - 360;
    }
    return result;
}

function mapAngle(angle) {
    var result = mirrorAngle(angle + 90);
    if (angle <= 90) {
        return result - 180;
    }
    return result + 180;
}

function offsetFromCenter(offset, degrees) {
    var center = fullWidth / 2;
    var radians = Math.toRadians(degrees + 90);
    var x = center - offset * Math.cos(radians);
    var y = center - offset * Math.sin(radians);
    return [toInteger(x), toInteger(y)];
}

function mapArcDegrees(start, end, rotation) {
    var degreeStart = mapAngle(start) - rotation;
    var degreeEnd = mapAngle(end) - rotation;
    return [degreeStart, degreeEnd];
}

// Draw an arc using normal clock degrees (0 = 12, 90 = 3)
function drawArc(dc, radius, start, end, position) {
    var offset = position.get(:offset) || 0;
    var rotation = position.get(:rotation) || 0;
    var angle = position.get(:angle) || 0;

    var xy = offsetFromCenter(offset, angle);
    var degrees = mapArcDegrees(start, end, rotation);

    dc.drawArc(
        xy[0],
        xy[1],
        radius,
        Gfx.ARC_CLOCKWISE,
        degrees[0],
        degrees[1]
    );
}

// Same as draw an arc, but is hollow (provide "thickness" as last param)
function drawHollowArc(dc, radius, start, end, position, thickness) {
    var offset = position.get(:offset) || 0;
    var rotation = position.get(:rotation) || 0;
    var angle = position.get(:angle) || 0;

    // Position
    var xy = offsetFromCenter(offset, angle);
    var x = xy[0];
    var y = xy[1];

    // Draw the arc
    var degreeStart = mapAngle(start) - rotation;
    var degreeEnd = mapAngle(end) - rotation;
    var innerRadius = radius - thickness + 8;
    var outerRadius = radius;
    dc.drawArc(x, y, innerRadius, Gfx.ARC_CLOCKWISE, degreeStart, degreeEnd);
    dc.drawArc(x, y, outerRadius, Gfx.ARC_CLOCKWISE, degreeStart, degreeEnd);

    // Draw arc close caps
    var delta = 2;
    drawLine(dc, x, y, innerRadius + delta, outerRadius + delta, Math.toRadians(start - 90));
    drawLine(dc, x, y, innerRadius + delta, outerRadius + delta, Math.toRadians(end - 90));
}

function drawLine(dc, x, y, innerRadius, outerRadius, radians) {
    var sX = x + innerRadius * Math.cos(radians);
    var sY = y + innerRadius * Math.sin(radians);
    var eX = x + outerRadius * Math.cos(radians);
    var eY = y + outerRadius * Math.sin(radians);
    dc.drawLine(sX, sY, eX, eY);
}

// Like "ticks" around a circle, draw the segments around the provided radius
// Iterates through the entire 360 but only draws a line when past the "start"
// threshold
function drawHashedArc(dc, radius, start, end, position, segments, length) {
    var offset = position.get(:offset) || 0;
    var rotation = position.get(:rotation) || 0;
    var angle = position.get(:angle) || 0;

    // Center point
    var xy = offsetFromCenter(offset, angle);
    var x = xy[0];
    var y = xy[1];
    var outerRadius = radius;
    var innerRadius = outerRadius - length;

    // Starting point
    var radians = Math.toRadians(-90);
    var dontDrawHashUntil = Math.toRadians(start-90);// Math.toRadians(end - 90);//Math.toRadians(360);//radians + Math.toRadians(start) - Math.toRadians(90);
    if (rotation) {
        radians = radians - Math.toRadians(rotation - 90);
        dontDrawHashUntil = dontDrawHashUntil - Math.toRadians(rotation - 90);
    }

    // End point
    var totalRadians = Math.toRadians(end);
    var oneFinalSegment = 0;
    if (end < 360) {
        oneFinalSegment = 1;
    }

    // Loop through segments
    for (var i = 0; i < segments + oneFinalSegment; i += 1) {
        if (radians >= dontDrawHashUntil) {
            drawLine(dc, x, y, innerRadius, outerRadius, radians);
        }

        radians += totalRadians / segments;
    }
}
