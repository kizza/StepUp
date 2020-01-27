using Toybox.Application as App;
using Toybox.System;

var debugIndex = 0;
var debugThemeIndex = 0;

class ThemePreview {
    function tick(dc) {
        var colours = [Colours.RED, Colours.ORANGE, Colours.YELLOW, Colours.GREEN, Colours.BLUE, Colours.PURPLE, Colours.PINK, Colours.AQUA, Colours.MINT];

        if (debugIndex % 2 == 0) {
            App.getApp().setProperty("Theme", colours[debugThemeIndex]);

            ThemePreview.mockData();

            handleSettingsChange();

            debugThemeIndex++;
            if (debugThemeIndex > colours.size() - 1) {
                debugThemeIndex = 0;
            }

            View.onUpdate(dc);
        }

        debugIndex++;
    }

    function mockData() {
        deviceSettings.notificationCount = 2;
        deviceSettings.phoneConnected = true;
        activityInfo.steps = randomNumber(8001) - 1;
        activityInfo.stepGoal = 8000;
        activityInfo.calories = 23467;
        activityInfo.moveBarLevel = randomNumber(5);
    }

    function previewData() {
        deviceSettings.notificationCount = 0;
        deviceSettings.phoneConnected = true;

        activityInfo.steps = 5432;
        activityInfo.stepGoal = 8000;
        activityInfo.calories = 23467;
        activityInfo.moveBarLevel = 3;

        batteryPercentage = 100;
        clockTime.hour = 12;
        clockTime.min = 35;
    }
}
