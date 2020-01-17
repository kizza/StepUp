using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class PrimaryDial extends Ui.Drawable {
    var thickness;

    function initialize(params) {
        Drawable.initialize(params);
        thickness = params[:thickness];
    }

    function draw(dc) {
        var percentage = (activityInfo.steps * 100) / activityInfo.stepGoal;

        // Gap at the bottom
        var position = { :offset => 0, :rotation => -135, :angle => 0 };
        var maxDegrees = 270;

        // Even 100%
        // var position = { :offset => 0, :rotation => 0, :angle => 0 };
        // var position = { :offset => 0, :rotation => -180, :angle => 0 };
        // var maxDegrees = 360;

        var cageSize = 0;
        var radius = fullWidth / 2 - thickness / 2;
        var placeholderColor = themeColours[:placeholder];
        var fillColor = settings[:dialColour];

        // If percentage is complete, use another color for the remainder
        if (percentage > 100) {
            percentage = percentage - 100;
            placeholderColor = themeColour;
            fillColor = settings[:bonusDialColour];
        }

        // Draw the goal placeholder arc
        var ratio = (percentage / 100.0) * maxDegrees;
        dc.setPenWidth(thickness);
        if (percentage < 100) {
            // dc.setPenWidth(thickness);
            // dc.setColor(placeholderColor, Gfx.COLOR_TRANSPARENT);
            // drawArc(dc, radius, ratio, maxDegrees, position);

            dc.setColor(fillColor, Gfx.COLOR_TRANSPARENT);
            dc.setPenWidth(2);
            drawHashedArc(dc, fullWidth / 2, ratio, maxDegrees, position, 20, thickness);
        }

        // Draw the fill arc
        if (percentage > 0) {
            dc.setPenWidth(thickness);
            dc.setColor(fillColor, Gfx.COLOR_TRANSPARENT);
            if (cageSize > 0) {
                drawArc(dc, radius - cageSize - (thickness/2) - 4, 0, ratio, position);
            } else {
                drawArc(dc, radius, 0, ratio, position);
            }
        }

        // Cage
        if (cageSize > 0) {
            dc.setPenWidth(2);
            dc.setColor(placeholderColor, Gfx.COLOR_TRANSPARENT);
            drawArc(dc, radius - cageSize, 0, maxDegrees, position);

            var segments = Math.ceil((percentage / 100.0) * 18);
            if (segments == 0) {
                segments = 18;
            }
            drawHashedArc(dc, radius, 0, maxDegrees, position, segments, cageSize - 2);
        }
    }
}
