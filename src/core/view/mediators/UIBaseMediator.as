package core.view.mediators {
    import core.configs.GeneralNotifications;

    import org.puremvc.as3.patterns.mediator.Mediator;

    public class UIBaseMediator extends Mediator {

        public function UIBaseMediator(name:String, viewComponent:Object) {

            super(name, viewComponent);
        }

        override public function onRegister():void {

            super.onRegister();
            registerListeners();
            sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, viewComponent.content);
        }

        protected function registerListeners():void {
        }

        override public function onRemove():void {

            super.onRemove();
            removeListeners();
            sendNotification(GeneralNotifications.REMOVE_CHILD, viewComponent.content);
        }

        protected function removeListeners():void {
        }
    }
}
