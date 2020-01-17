using Toybox.Graphics as Gfx;
using Toybox.Lang;
using Toybox.Time.Gregorian;
using Toybox.WatchUi as Ui;

class HorizontalDate extends Ui.Drawable {
    var font;
    var iconFont;
    var offset;
    var offsetAngle;

    function initialize(params) {
        Drawable.initialize(params);
        offset = params[:offset];
        offsetAngle = params[:offsetAngle];
        font = Gfx.FONT_XTINY;//Ui.loadResource(Rez.Fonts.DigitalFont);
        iconFont = Ui.loadResource(Rez.Fonts.IconFont);
    }

    function draw(dc) {
        var info = getDate();
        var label = Lang.format("$1$ $2$ $3$", [info[:day], info[:date], info[:month]]);
        label = label.toUpper();
        var position = offsetFromCenter(offset, offsetAngle);
        var labelWidth = dc.getTextWidthInPixels(label, font);

        dc.setColor(settings[:dateColour], Gfx.COLOR_TRANSPARENT);
        dc.drawText(position[0], position[1], font, label, Graphics.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);

        if (deviceSettings.notificationCount > 0) {
            dc.setColor(themeColour, Gfx.COLOR_TRANSPARENT);
            dc.drawText(position[0] + labelWidth / 2 + 4, position[1], iconFont, "2", Graphics.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);
        }
    }

    function getDate() {
        var info = Gregorian.info(Time.now(), Time.FORMAT_LONG);
        return {
            :day => info.day_of_week.substring(0, 3),
            :date => info.day,
            :month => info.month.substring(0, 3)
        };
    }
}
