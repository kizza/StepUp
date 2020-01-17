using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class Notifications extends Ui.Drawable {
    var iconFont;
    var offset;
    var offsetAngle;

    function initialize(params) {
        Drawable.initialize(params);
        offset = params[:offset];
        offsetAngle = params[:offsetAngle];
        iconFont = Ui.loadResource(Rez.Fonts.IconFont);
    }

    function draw(dc) {
        var position = offsetFromCenter(offset, offsetAngle);
        var iconWidth = dc.getTextWidthInPixels("1", iconFont);
        var icons = getIcons();

        var iconCount = icons.size();

        var gap = 4;
        var totalWidth = iconCount * 24 + iconCount * gap;

        var x = position[0] - totalWidth / 2;
        var y = position[1];

        dc.setColor(themeColour, Gfx.COLOR_TRANSPARENT);


        for (var i = 0; i < icons.size(); i++) {
            dc.drawText(x, y, iconFont, icons[i], Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);
            x = x + iconWidth + gap;
        }
    }

    function getIcons() {
        var icons = [];
        if (deviceSettings.notificationCount > 0) {
            icons.add("2");
        }
        if (deviceSettings.phoneConnected == true) {
            icons.add("1");
        }
        return icons;
    }
}
