using Toybox.Application as App;
using Toybox.System;

var tickCount = 0;
var themeIndex = 0;
var dataIndex = 0;

class ThemePreview {
    function tick(dc) {
        System.println("Tick " + tickCount);
        if (tickCount % 2 == 0) {
            ThemePreview.tickTheme();
            ThemePreview.tickData();

            handleSettingsChange();
            View.onUpdate(dc);
        }

        tickCount++;
    }

    function tickTheme() {
        var colours = [
            Colours.RED, Colours.ORANGE, Colours.YELLOW, Colours.GREEN, Colours.BLUE, Colours.PURPLE, Colours.PINK, Colours.AQUA, Colours.MINT
        ];

        App.getApp().setProperty("Theme", colours[themeIndex]);

        themeIndex++;
        if (themeIndex > colours.size() - 1) {
            themeIndex = 0;
        }
    }

    function tickData() {
        if (dataIndex == 0) {
            activityInfo.stepGoal = 1000;
            clockTime.hour = 12;
            clockTime.min = 35;
        } else if (dataIndex == 1) {
            clockTime.hour = 20;
            clockTime.min = 35;
        } else if (dataIndex >= 2) {
            clockTime.hour = 20;
            clockTime.min = 00;
        }

        dataIndex++;
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
