using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class Background extends Ui.Drawable {

    function initialize() {
        Drawable.initialize({ :identifier => "Background" });
    }

    function draw(dc) {
        dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);
        dc.clear();
    }
}
