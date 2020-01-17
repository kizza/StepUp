using Toybox.Application as App;
using Toybox.Graphics as Gfx;

function getSettings() {
    var themeColour = getColour("Theme", Colours.MINT);
    var secondaryColour = getSecondaryColour(themeColour);

    var settings = {
        :themeColour => themeColour,
        :enlargeHours => getProperty("EnlargeHours"),
        :hourFont => getProperty("HourFont"),
        :hourColour => getColour("HourColour", 0xFFFFFF),
        :minuteColour => getColour("MinuteColour", themeColour),
        :dateColour => getColour("DateColour", Gfx.COLOR_WHITE),
        :metricColour => getColour("MetricColour", themeColour),
        :dialColour => getColour("DialColour", themeColour),
        :bonusDialColour => getColour("BonusDialColour", Colours.PINK),
        :moveBarColour => getColour("MoveBarColour", secondaryColour),
        :moveBarColourAlmostFull => getColour("MoveBarColourAlmostFull", Colours.ORANGE),
        :moveBarColourFull => getColour("MoveBarColourFull", Colours.RED)
    };

    // settings[:hourFont] = 1;
    // settings[:dialColour] = 0xFFFFFF;
    // settings[:hourColour] = 0xFF0000;
    // settings[:dateColour] = Colours.PINK;
    // settings[:metricColour] = Colours.ORANGE;
    // settings[:moveBarColour] = 0x56FFAC;

    return settings;
}

function getProperty(key) {
    return App.getApp().getProperty(key);
}

function getColour(key, fallback) {
    var value = App.getApp().getProperty(key).toNumber();
    if (value != -1) {
        return value;
    }
    return fallback;
}
