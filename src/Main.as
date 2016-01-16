package {

    import core.GameFacade;
    import core.controller.commands.StartupCommand;

    import flash.display.Sprite;
    import flash.display.StageOrientation;
    import flash.display.StageScaleMode;
    import flash.events.Event;

    public class Main extends Sprite {

        public function Main() {

            setPredefineSettings();
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function setPredefineSettings():void {

            stage.scaleMode = StageScaleMode.EXACT_FIT;
            stage.autoOrients = false;
            stage.setOrientation(StageOrientation.ROTATED_LEFT);
        }

        private function onAddedToStage(event:Event):void {

            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            GameFacade.getInstance().startup(StartupCommand, this);
        }
    }
}
