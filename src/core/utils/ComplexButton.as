package core.utils {

    import flash.display.InteractiveObject;
    import flash.display.MovieClip;
    import flash.events.EventDispatcher;
    import flash.events.MouseEvent;

    public class ComplexButton extends EventDispatcher {

        private const LABEL_UP:String = "up";
        private const LABEL_OVER:String = "over";
        private const LABEL_DOWN:String = "down";
        private const LABEL_DISABLE:String = "disable";

        private var isEnable:Boolean;
        private var content:MovieClip;
        private var hitZone:InteractiveObject;
        private var current_button_state:String;

        public function ComplexButton(content:MovieClip) {

            this.content = content;
            init();
        }

	    public function set enable(value:Boolean):void {

		    isEnable = value;
		    hitZone.mouseEnabled = value;
            current_button_state = value ? LABEL_UP : LABEL_DISABLE;
		    updateView();
	    }

        private function init():void {

            hitZone = content["hit"] as InteractiveObject;
            current_button_state = LABEL_UP;
	        isEnable = true;

            addListeners();
            updateView();
        }

        private function updateView():void {

            content.gotoAndStop(current_button_state);
        }

        public function addListeners():void {

            hitZone.addEventListener(MouseEvent.MOUSE_OVER, handleMouseActivity);
            hitZone.addEventListener(MouseEvent.MOUSE_OUT, handleMouseActivity);
            hitZone.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseActivity);
            hitZone.addEventListener(MouseEvent.CLICK, handleMouseActivity);
        }

        private function handleMouseActivity(event:MouseEvent):void {

	        if (!isEnable){
		        return;
	        }

            switch(event.type) {
                case MouseEvent.MOUSE_OVER: {
                    current_button_state = LABEL_OVER;
                    break;
                }
                case MouseEvent.MOUSE_OUT: {
                    current_button_state = LABEL_UP;
                    break;
                }
                case MouseEvent.MOUSE_DOWN: {
                    current_button_state = LABEL_DOWN;
                    break;
                }
            }
            updateView();
            dispatchEvent(event);
        }

        public function destroy():void {

            hitZone.removeEventListener(MouseEvent.MOUSE_OVER, handleMouseActivity);
            hitZone.removeEventListener(MouseEvent.MOUSE_UP, handleMouseActivity);
            hitZone.removeEventListener(MouseEvent.MOUSE_DOWN, handleMouseActivity);
            hitZone.removeEventListener(MouseEvent.CLICK, handleMouseActivity);

            content = null;
        }
    }
}
