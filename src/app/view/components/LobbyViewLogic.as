package app.view.components {
	import core.view.components.ViewLogic;

	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class LobbyViewLogic extends ViewLogic{

		public static const EVENT_ON_START_CLICKED:String = "onStartClicked";

		private var startButton:SimpleButton;

		public function LobbyViewLogic(linkage:String) {

			super (linkage);
			init();
		}

		private function init():void {

			startButton = content["start"] as SimpleButton;
			startButton.addEventListener(MouseEvent.CLICK, onStartClick);
		}

		private function onStartClick(event:MouseEvent):void {

			dispatchEvent(new Event(EVENT_ON_START_CLICKED));
		}
	}
}
