package app.view.mediators {
    import app.config.GeneralAppNotifications;
    import app.model.proxy.MainProxy;
    import app.view.components.LevelViewLogic;

    import core.view.mediators.UIBaseMediator;

    import flash.events.Event;

    import org.puremvc.as3.interfaces.INotification;

    public class LevelMediator extends UIBaseMediator {

        public static const NAME:String = "LevelMediator";

        private var viewLogic:LevelViewLogic;

        public function LevelMediator() {

            viewLogic = new LevelViewLogic("question_frame");

            super(NAME, viewLogic);
        }

        override public function onRegister():void {

            super.onRegister();
            viewLogic.init(mainProxy);
        }

        override protected function registerListeners():void {

            super.registerListeners();

            viewLogic.addEventListener(LevelViewLogic.EVENT_NO_BUTTON_CLICKED, onNoButtonClicked);
            viewLogic.addEventListener(LevelViewLogic.EVENT_YES_BUTTON_CLICKED, onYesButtonClicked);
        }

        override protected function removeListeners():void {

            super.removeListeners();

            viewLogic.removeEventListener(LevelViewLogic.EVENT_NO_BUTTON_CLICKED, onNoButtonClicked);
            viewLogic.removeEventListener(LevelViewLogic.EVENT_YES_BUTTON_CLICKED, onYesButtonClicked);
        }

        private function onNoButtonClicked(event:Event):void {

            mainProxy.nextQuestion();
        }

        private function onYesButtonClicked(event:Event):void {

            mainProxy.markCurrentQuestionAsPositive();
            mainProxy.nextQuestion();
        }

        override public function handleNotification(notification:INotification):void {

            super.handleNotification(notification);

            switch(notification.getName()) {
                case GeneralAppNotifications.SHOW_QUESTION: {
                    viewLogic.setQuestion();
                    break;
                }
            }
        }

        override public function listNotificationInterests():Array {

            return super.listNotificationInterests().concat([
                                                            GeneralAppNotifications.SHOW_QUESTION
                                                            ]);
        }

        private function get mainProxy():MainProxy {

            return facade.retrieveProxy(MainProxy.NAME) as MainProxy;
        }
    }
}
