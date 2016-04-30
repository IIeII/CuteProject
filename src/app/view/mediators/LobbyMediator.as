package app.view.mediators {
	import app.config.GeneralAppNotifications;
	import app.view.components.LobbyViewLogic;

	import core.view.mediators.UIBaseMediator;

	import flash.events.Event;

	public class LobbyMediator extends UIBaseMediator{

		public static const NAME:String = "LobbyMediator";

		private var viewLogic:LobbyViewLogic;

		public function LobbyMediator() {

			viewLogic = new LobbyViewLogic("lobby_frame");

			super (NAME, viewLogic);
		}

		override protected function registerListeners():void {
			super.registerListeners();
			viewLogic.addEventListener(LobbyViewLogic.EVENT_ON_START_CLICKED, onStartClicked);
		}

		override protected function removeListeners():void {
			super.removeListeners();
			viewLogic.removeEventListener(LobbyViewLogic.EVENT_ON_START_CLICKED, onStartClicked);
		}

		private function onStartClicked(event:Event):void {

			sendNotification(GeneralAppNotifications.START_TESTING);
		}
	}
}
