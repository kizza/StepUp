using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class DigitalFace extends Ui.Drawable {
    var font;
    var largeFonts;

    function initialize(params) {
        Drawable.initialize(params);

        font = Ui.loadResource(Rez.Fonts.DigitalFont);
        largeFonts = [
            Ui.loadResource(Rez.Fonts.HourFont),
            Ui.loadResource(Rez.Fonts.HourFontSporty)
        ];
    }

    function draw(dc) {
        var hours = clockTime.hour % 12;
        var minutes = clockTime.min.format("%02d");

        if (hours == 0) {
            hours = 12;
        }

        drawCenteredDigitalFace(dc, hours.toString(), minutes);
    }

    function drawCenteredDigitalFace(dc, hours, minutes) {
        var hourFont = font;
        var hourGap = 0;
        if (settings[:enlargeHours] == true) {
            var hourFontIndex = settings[:hourFont];
            hourFont = largeFonts[hourFontIndex];
            hourGap = -2;
        }

        // Calculate
        var hoursWidth = dc.getTextWidthInPixels(hours, hourFont);
        var minutesWidth = dc.getTextWidthInPixels(minutes, font);
        var x = fullWidth / 2 - ((hoursWidth + hourGap + minutesWidth) / 2);
        var y = fullHeight / 2 - Gfx.getFontHeight(font) / 2;

        // Hours
        dc.setColor(settings[:hourColour], Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, hourFont, hours, Graphics.TEXT_JUSTIFY_LEFT);

        // Minutes
        dc.setColor(settings[:minuteColour], Graphics.COLOR_TRANSPARENT);
        dc.drawText(x + hoursWidth + hourGap, y, font, minutes, Graphics.TEXT_JUSTIFY_LEFT);
    }

    function drawHashMarks(dc) {
        var position = { :offset => 0, :rotation => 0, :angle => 0 };
        var radius = fullWidth / 2;
        dc.setPenWidth(2);
        drawHashedArc(dc, radius, 0, 360, position, 12, 12);
    }
}
