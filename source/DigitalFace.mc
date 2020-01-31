using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class DigitalFace extends Ui.Drawable {
    var largeFont;
    var normalFont;
    var smallFont;
    var smallestFont;

    function initialize(params) {
        Drawable.initialize(params);

        largeFont = Ui.loadResource(Rez.Fonts.HourFont);
        normalFont = Ui.loadResource(Rez.Fonts.DigitalFont);
        smallFont = Ui.loadResource(Rez.Fonts.SmallerFont);
        smallestFont = Ui.loadResource(Rez.Fonts.SmallestFont);
    }

    function draw(dc) {
        var hours = clockTime.hour;
        var minutes = clockTime.min.format("%02d");

        if (!deviceSettings.is24Hour) {
            hours = hours % 12;
            if (hours == 0) {
                hours = 12;
            }
        }

        drawCenteredDigitalFace(dc, hours.toString(), minutes);
    }

    function drawCenteredDigitalFace(dc, hours, minutes) {
        // Typography
        var typography = getTypography(dc, hours, minutes);
        var hourFont = typography[0];
        var minuteFont = typography[1];
        var hourGap = typography[2];

        // Position
        var hoursWidth = dc.getTextWidthInPixels(hours, hourFont);
        var labelWidth = calculateFontWidth(dc, hours, minutes, hourFont, minuteFont, hourGap);
        var x = fullWidth / 2 - (labelWidth / 2);
        var y = fullHeight / 2 - Gfx.getFontHeight(minuteFont) / 2;

        // Hours
        dc.setColor(settings[:hourColour], Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, hourFont, hours, Graphics.TEXT_JUSTIFY_LEFT);

        // Minutes
        dc.setColor(settings[:minuteColour], Graphics.COLOR_TRANSPARENT);
        dc.drawText(x + hoursWidth + hourGap, y, minuteFont, minutes, Graphics.TEXT_JUSTIFY_LEFT);
    }

    function getTypography(dc, hours, minutes) {
        var hourFont = normalFont;
        var minuteFont = normalFont;
        var gap = 0;

        var attempts = [
            [largeFont, normalFont, -2],
            [normalFont, smallFont, -2],
            [smallFont, smallestFont, -2]
        ];

        if (settings[:enlargeHours] != true) {
            attempts = [
                [normalFont, normalFont, 0],
                [smallFont, smallFont, 0],
                [smallestFont, smallestFont, 0]
            ];
        }

        var attempt;
        var width;
        for (var i=0; i<attempts.size(); i++) {
            attempt = attempts[i];
            width = calculateFontWidth(dc, hours, minutes, attempt[0], attempt[1], attempt[2]);
            if (width < fullWidth * 0.94) {
                return [attempt[0], attempt[1], attempt[2]];
            }
        }

        return [smallFont, smallFont, 0];
    }

    function calculateFontWidth(dc, hours, minutes, hourFont, minuteFont, gap) {
        var hoursWidth = dc.getTextWidthInPixels(hours, hourFont);
        var minutesWidth = dc.getTextWidthInPixels(minutes, minuteFont);
        return hoursWidth + gap + minutesWidth;
    }

    function drawHashMarks(dc) {
        var position = { :offset => 0, :rotation => 0, :angle => 0 };
        var radius = fullWidth / 2;
        dc.setPenWidth(2);
        drawHashedArc(dc, radius, 0, 360, position, 12, 12);
    }
}
