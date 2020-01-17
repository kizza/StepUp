using Toybox.Application;
using Toybox.WatchUi as Ui;

class StepUp extends Application.AppBase
{
    var view = null;

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        view = new MainView();

        if( Toybox.WatchUi has :WatchFaceDelegate ) {
            return [view, new WatchDelegate()];
        } else {
            return [view];
        }
    }

    function onSettingsChanged() {
        view.handleSettingsChange();
        Ui.requestUpdate();
    }
}
