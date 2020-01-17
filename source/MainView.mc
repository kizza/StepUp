using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.WatchUi;

var fullWidth = 240;
var fullHeight = 240;
var themeColour = 0x56FFAC;
var themeColours = {
    :placeholder => 0x2B2B2B
};
var partialUpdatesAllowed = false;
var dateTime;
var activityInfo;
var deviceSettings;
var batteryPercentage;
var clockTime;
var settings;

class MainView extends WatchUi.WatchFace
{
    var font;
    var iconFont;
    var isAwake;
    var screenShape;
    var screenCenterPoint;

    function initialize() {
        WatchFace.initialize();
        partialUpdatesAllowed = ( Toybox.WatchUi.WatchFace has :onPartialUpdate );
    }

    function onLayout(dc) {
        font = WatchUi.loadResource(Rez.Fonts.DigitalFont);
        iconFont = WatchUi.loadResource(Rez.Fonts.IconFont);
        fullWidth = dc.getWidth();
        fullHeight = dc.getHeight();

        setLayout(Rez.Layouts.WatchFace(dc));
        handleSettingsChange();
    }

    function onUpdate(dc) {
        getLatestData();
        // ThemePreview.previewData();
        View.onUpdate(dc);
    }

    // function onPartialUpdate(dc) {
    //     ThemePreview.tick(dc);
    // }

    function handleSettingsChange() {
        settings = getSettings();
        themeColour = settings[:themeColour];
    }

    function getLatestData() {
        deviceSettings = System.getDeviceSettings();
        activityInfo = ActivityMonitor.getInfo();
        if (activityInfo.stepGoal == 0) {
            activityInfo.stepGoal = 5000;
        }

        batteryPercentage = (System.getSystemStats().battery + 0.5).toNumber();
        clockTime = System.getClockTime();
    }

    // This method is called when the device re-enters sleep mode.
    // Set the isAwake flag to let onUpdate know it should stop rendering the second hand.
    function onEnterSleep() {
        isAwake = false;
        WatchUi.requestUpdate();
    }

    // This method is called when the device exits sleep mode.
    // Set the isAwake flag to let onUpdate know it should render the second hand.
    function onExitSleep() {
        isAwake = true;
        WatchUi.requestUpdate();
    }
}

class WatchDelegate extends WatchUi.WatchFaceDelegate {
    function initialize() {
        WatchFaceDelegate.initialize();
    }

    // The onPowerBudgetExceeded callback is called by the system if the
    // onPartialUpdate method exceeds the allowed power budget. If this occurs,
    // the system will stop invoking onPartialUpdate each second, so we set the
    // partialUpdatesAllowed flag here to let the rendering methods know they
    // should not be rendering a second hand.
    function onPowerBudgetExceeded(powerInfo) {
        System.println( "Average execution time: " + powerInfo.executionTimeAverage );
        System.println( "Allowed execution time: " + powerInfo.executionTimeLimit );
        partialUpdatesAllowed = false;
    }
}
