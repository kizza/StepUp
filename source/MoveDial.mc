using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.WatchUi as Ui;

class MoveDial extends Ui.Drawable {
    var thickness;
    var radius;
    var position;
    var colours;

    function initialize(params) {
        Drawable.initialize({ :identifier => "MoveDial" });
        thickness = params[:thickness];
        position = { :offset => 0, :rotation => 0, :angle => 0 };
        radius = fullWidth / 2 - thickness / 2;
    }

    function draw(dc) {
        colours = getSegmentColours(activityInfo.moveBarLevel);

        // Draw the segments
        drawSegment(dc, radius, 1, 180.4, 219.4, position); // Odd numbers to resolve pixel placement
        drawSegment(dc, radius, 2, 170, 176, position);
        drawSegment(dc, radius, 3, 160, 166, position);
        drawSegment(dc, radius, 4, 150, 156, position);
        drawSegment(dc, radius, 5, 140, 146, position);
    }

    function drawSegment(dc, radius, level, start, end, position) {
        var barThickness = getLineThickness(level);
        dc.setColor(colours[level - 1], Gfx.COLOR_TRANSPARENT);

        if (activityInfo.moveBarLevel >= level) {
            dc.setPenWidth(barThickness);
            drawArc(dc, radius, start, end, position);
        } else {
            dc.setPenWidth(2);
            var hollowThickness = max(thickness + 8, getHollowThickness(level));
            drawHollowArc(dc, radius, start, end, position, hollowThickness);
        }
    }

    function getSegmentColours(level) {
        var normal = settings[:moveBarColour];
        var almost = settings[:moveBarColourAlmostFull];
        var full = settings[:moveBarColourFull];
        var empty = themeColours[:placeholder];
        empty = normal;

        if (level == 5) {
            return [full, full, full, full, full];
        } else if (level == 4) {
            empty = almost;
            return [almost, almost, almost, almost, empty];
        } else if (level == 3) {
            return [normal, normal, normal, empty, empty];
        } else if (level == 2) {
            return [normal, normal, empty, empty, empty];
        } else if (level == 1) {
            return [normal, empty, empty, empty, empty];
        } else {
            return [empty, empty, empty, empty, empty];
        }
    }

    function getLineThickness(level) {
        var growth = thickness * 3;
        return thickness + Math.floor(level / 5.0 * growth);
    }

    function getHollowThickness(level) {
        var growth = thickness * 2.6;
        return thickness + Math.floor(level / 5.0 * growth);
    }
}
