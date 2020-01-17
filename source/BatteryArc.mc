using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.WatchUi as Ui;

class BatteryArc extends Ui.Drawable {
    var offset;
    var offsetAngle;

    function initialize(params) {
        Drawable.initialize({ :identifier => "Battery" });
        offset = params[:offset];
        offsetAngle = params[:offsetAngle];
    }

    function draw(dc) {
        var batteryPercentage = (System.getSystemStats().battery + 0.5).toNumber();
        var position = { :offset => offset, :angle => offsetAngle, :rotation => 140 };
        batteryPercentage = 100;
        var ratio = (batteryPercentage / 100.0) * 80;

        dc.setPenWidth(4);
        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
        drawArc(dc, fullWidth / 2, 80 - ratio, 80, position);
    }
}
