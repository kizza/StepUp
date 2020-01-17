using Toybox.Graphics as Gfx;
using Toybox.Time.Gregorian;
using Toybox.WatchUi as Ui;

class Metric extends Ui.Drawable {
    var metric;
    var font;
    var iconFont;
    var offset;
    var offsetAngle;

    function initialize(params) {
        Drawable.initialize(params);
        metric = params[:metric];
        offset = params[:offset];
        offsetAngle = params[:offsetAngle];
        font = Gfx.FONT_TINY;
        iconFont = Ui.loadResource(Rez.Fonts.IconFont);
    }

    function draw(dc) {
        var label = getLabel();
        var position = offsetFromCenter(offset, offsetAngle);
        var iconWidth = dc.getTextWidthInPixels(label[:icon], iconFont);
        var textWidth = dc.getTextWidthInPixels(label[:value], font);
        var gap = 4;

        var x = position[0] - (iconWidth + gap + textWidth) / 2;
        var y = position[1];

        dc.setColor(settings[:metricColour], Gfx.COLOR_TRANSPARENT);
        dc.drawText(x - 4, y + 2, iconFont, label[:icon], Gfx.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(x - 4 + iconWidth + gap, y, font, label[:value], Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);
    }

    function getLabel() {
        if (metric == :steps) {
            return {:icon => "0", :value => activityInfo.steps.toString()};
        }
        if (metric == :calories) {
            return {:icon => "3", :value => activityInfo.calories.toString()};
        }

        return {:icon => "0", :value => "unknown" };
    }
}
