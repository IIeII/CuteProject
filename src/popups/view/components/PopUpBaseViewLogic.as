package popups.view.components {
    import core.view.components.ViewLogic;

    public class PopUpBaseViewLogic extends ViewLogic{

        private var _modalMode:Boolean;

        public function PopUpBaseViewLogic(instanceName:String = "", modalMode:Boolean = true) {

            super(instanceName);

            _modalMode = modalMode;
        }

        public function init():void {

        }


        public function destroy():void {

        }
    }
}
