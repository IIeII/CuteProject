package popups.view.mediators {
    import core.utils.EventWithData;
    import core.view.mediators.UIBaseMediator;

    import popups.config.PopUpBaseEvents;
    import popups.config.PopUpBaseNotifications;

    import popups.model.PopUpActionVO;
    import popups.view.components.PopUpBaseViewLogic;

    public class PopUpBaseMediator extends UIBaseMediator {

        protected var _doActionVO:PopUpActionVO;
        protected var _closeActionVO:PopUpActionVO;
        protected var _viewLogic:PopUpBaseViewLogic;

        public function PopUpBaseMediator(name:String, viewComponent:PopUpBaseViewLogic, doActionVO:PopUpActionVO = null, closeActionVO:PopUpActionVO = null) {
            super (name, viewComponent);

            _viewLogic = viewComponent;
            _doActionVO = doActionVO;
            _closeActionVO = closeActionVO;
        }

        override public function onRegister():void {
            super.onRegister();
            _viewLogic.init();
        }

        override public function onRemove():void {
            super.onRemove();
            _viewLogic.destroy();
        }

        override protected function registerListeners():void {
            super.registerListeners();

            _viewLogic.addEventListener(PopUpBaseEvents.DO_BUTTON_PRESSED, onDoButtonPressed);
            _viewLogic.addEventListener(PopUpBaseEvents.CLOSE_BUTTON_PRESSED, onCloseButtonPressed);
        }

        override protected function removeListeners():void {
            super.removeListeners();

            _viewLogic.removeEventListener(PopUpBaseEvents.DO_BUTTON_PRESSED, onDoButtonPressed);
            _viewLogic.removeEventListener(PopUpBaseEvents.CLOSE_BUTTON_PRESSED, onCloseButtonPressed);
        }

        private function onCloseButtonPressed(event:EventWithData):void {

            var isCameFromCloseButton:Boolean = true;

            makeAction(_closeActionVO, isCameFromCloseButton);
        }

        private function onDoButtonPressed(event:EventWithData):void {

            var isCameFromCloseButton:Boolean = false;

            makeAction(_closeActionVO, isCameFromCloseButton);
        }

        private function makeAction(popUpActionVO:PopUpActionVO, isCameFromCloseButton:Boolean):void {

            if (popUpActionVO){

                sendNotification(popUpActionVO.notificationName, popUpActionVO.notificationBody, popUpActionVO.notificationType);
            }

            if ((popUpActionVO && popUpActionVO..shouldClose) || isCameFromCloseButton){

                closePopUp();
            }
        }

        private function closePopUp():void {

            sendNotification(PopUpBaseNotifications.POP_UP_CLOSED, mediatorName);
            facade.removeMediator(mediatorName);
        }
    }
}
