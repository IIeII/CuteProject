package core.view.components {
    import core.utils.Warehouse;

    import flash.display.Sprite;
	import flash.events.EventDispatcher;

	public class ViewLogic extends EventDispatcher {

        protected var _content:Sprite;

        public function ViewLogic(instanceName:String = "") {

            _content = instanceName == "" ? new Sprite() : getBaseView(instanceName);
        }

		private function getBaseView(instanceName:String):Sprite {

			return Warehouse.getInstance().getClassByLinkage(instanceName) as Sprite;
		}

        public function get content():Sprite {

            return _content;
        }
    }
}
