using Toybox.Graphics as Gfx;

class Colours {
    var RED = 0xFF0000;
    var ORANGE = 0xFF5500;
    var YELLOW = 0xFFFF00;
    var GREEN = 0x00FF00;
    var BLUE = 0x00AAFF;
    var PURPLE = 0xAA00FF;
    var PINK = 0xFF34B8;
    var AQUA = 0x00FFFF;
    var MINT = 0x56FFAC;
    var WHITE = 0xFFFFFF;
    var BLACK = 0x000000;
}

function getSecondaryColour(primaryColour) {
    if (primaryColour == Colours.RED) { return Colours.ORANGE; }
    if (primaryColour == Colours.ORANGE) { return Colours.RED; }
    if (primaryColour == Colours.YELLOW) { return Colours.AQUA; }
    if (primaryColour == Colours.GREEN) { return Colours.WHITE; }
    if (primaryColour == Colours.BLUE) { return Colours.YELLOW; }
    if (primaryColour == Colours.PURPLE) { return Colours.MINT; }
    if (primaryColour == Colours.PINK) { return Colours.YELLOW; }
    if (primaryColour == Colours.AQUA) { return Colours.WHITE; }
    if (primaryColour == Colours.MINT) { return Colours.PURPLE; }
    return primaryColour;
}
