package popups.view.components {
    import core.view.components.ViewLogic;

    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.events.MouseEvent;

    import popups.config.PopUpBaseEvents;

    public class PopUpBaseViewLogic extends ViewLogic {

        private var _modalMode:Boolean;

        private var _doButton:SimpleButton;
        private var _closeButton:SimpleButton;

        public function PopUpBaseViewLogic(instanceName:String = "", modalMode:Boolean = true) {

            super(instanceName);

            _modalMode = modalMode;
        }

        public function init():void {

            initModalMode();
            initButtons();
        }

        private function initModalMode():void {

            if (!_modalMode){
                return;
            }

            // draw modal mode

        }

        private function initButtons():void {

            if (content["do_button"]){
                _doButton = content["do_button"] as SimpleButton;
                _doButton.addEventListener(MouseEvent.CLICK, onDoButtonClicked);
            }
            if (content["close_button"]){
                _closeButton = content["close_button"] as SimpleButton;
                _closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClicked);
            }
        }

        private function onDoButtonClicked(event:MouseEvent):void {

            dispatchEvent(new Event(PopUpBaseEvents.DO_BUTTON_PRESSED));
        }

        private function onCloseButtonClicked(event:MouseEvent):void {

            dispatchEvent(new Event(PopUpBaseEvents.CLOSE_BUTTON_PRESSED));
        }

        private function clearButtonListeners():void {

            if (_doButton != null){
                _doButton.removeEventListener(MouseEvent.CLICK, onDoButtonClicked);
            }

            if (_closeButton != null){
                _closeButton.removeEventListener(MouseEvent.CLICK, onCloseButtonClicked);
            }
        }

        public function destroy():void {

            clearButtonListeners();
        }
    }
}
