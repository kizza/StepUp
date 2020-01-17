using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.WatchUi as Ui;

class Battery extends Ui.Drawable {
    var offset;
    var offsetAngle;

    function initialize(params) {
        Drawable.initialize({ :identifier => "Battery" });
        offset = params[:offset];
        offsetAngle = params[:offsetAngle];
    }

    function draw(dc) {
        if (batteryPercentage <= 50) {

            // Don't offset battery when hours are normal size
            if (settings[:enlargeHours] != true) {
                offset = 38;
                offsetAngle = 180;
            }

            var position = offsetFromCenter(offset, offsetAngle);
            drawBattery(dc, position[0], position[1], batteryPercentage);
        }
    }

    function drawBattery(dc, x, y, percentage) {
        var outlineColour = Gfx.COLOR_DK_GRAY;
        var fillColour = themeColour;
        var width = 22;
        var height = 12;
        x = x - width / 2;

        // Red if below 10%
        if (percentage < 10) {
            fillColour = Colours.RED;
            outlineColour = Colours.RED;
        }

        // Fill
        dc.setPenWidth(2);
        dc.setColor(fillColour, Gfx.COLOR_TRANSPARENT);
        dc.fillRectangle(x, y, width * (percentage / 100.0), height);

        // Box
        dc.setColor(outlineColour, Gfx.COLOR_TRANSPARENT);
        dc.drawRectangle(x, y, width, height);

        // End piece
        dc.setColor(outlineColour, Gfx.COLOR_TRANSPARENT);
        dc.drawRectangle(x + width, y + height / 2 - 2, 4, 4);
        dc.setPenWidth(1);
    }
}
