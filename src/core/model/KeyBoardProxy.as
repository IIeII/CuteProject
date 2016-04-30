package core.model {
	import core.configs.KeyBoardNotifications;
	import core.configs.KeyCodes;

	import flash.display.Sprite;
	import flash.events.KeyboardEvent;

	import org.puremvc.as3.patterns.proxy.Proxy;

	public class KeyBoardProxy extends Proxy {

		public static const NAME:String = "KeyBoardProxy";

		private var alreadyPressedKeys:Array = [];

		public function KeyBoardProxy(root:Sprite) {

			super(NAME);

			root.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			root.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}

		private function onKeyUp(event:KeyboardEvent):void {

			switch (event.keyCode){

				case KeyCodes.UP_KEY: {
					handleKeyUp(KeyCodes.UP_KEY, KeyBoardNotifications.UP_KEY_RELEASED);
					break;
				}
				case KeyCodes.DOWN_KEY: {
					handleKeyUp(KeyCodes.DOWN_KEY, KeyBoardNotifications.DOWN_KEY_RELEASED);
					break;
				}
				case KeyCodes.LEFT_KEY: {
					handleKeyUp(KeyCodes.LEFT_KEY, KeyBoardNotifications.LEFT_KEY_RELEASED);
					break;
				}
				case KeyCodes.RIGHT_KEY: {
					handleKeyUp(KeyCodes.RIGHT_KEY, KeyBoardNotifications.RIGHT_KEY_RELEASED);
					break;
				}
			}
		}

		private function onKeyDown(event:KeyboardEvent):void {

			switch (event.keyCode){

				case KeyCodes.UP_KEY: {
					handleKeyDown(KeyCodes.UP_KEY, KeyBoardNotifications.UP_KEY_PRESSED);
					break;
				}
				case KeyCodes.DOWN_KEY: {
					handleKeyDown(KeyCodes.DOWN_KEY, KeyBoardNotifications.DOWN_KEY_PRESSED);
					break;
				}
				case KeyCodes.LEFT_KEY: {
					handleKeyDown(KeyCodes.LEFT_KEY, KeyBoardNotifications.LEFT_KEY_PRESSED);
					break;
				}
				case KeyCodes.RIGHT_KEY: {
					handleKeyDown(KeyCodes.RIGHT_KEY, KeyBoardNotifications.RIGHT_KEY_PRESSED);
					break;
				}
			}
		}

		private function handleKeyDown(keyCode:int, notificationName:String):void {

			if (alreadyPressedKeys.indexOf(keyCode) == -1){

				alreadyPressedKeys.push(keyCode);
				sendNotification(notificationName);
			}
		}

		private function handleKeyUp(keyCode:int, notificationName:String):void {

			alreadyPressedKeys.splice(alreadyPressedKeys.indexOf(keyCode), 1);
			sendNotification(notificationName);
		}

	}
}
