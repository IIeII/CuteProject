package app.view.mediators {
	import app.config.GeneralAppNotifications;
	import app.model.proxy.MainProxy;
	import app.model.proxy.VKAPIProxy;
	import app.view.components.ResultViewLogic;

	import core.view.mediators.UIBaseMediator;

	import flash.events.Event;

	import org.puremvc.as3.interfaces.INotification;

	public class ResultMediator extends UIBaseMediator{

		public static const NAME:String = "ResultMediator";

		private var viewLogic:ResultViewLogic;

		public function ResultMediator() {

			viewLogic = new ResultViewLogic("result_frame");

			super (NAME, viewLogic);
		}

		override public function onRegister():void {
			super.onRegister();

			viewLogic.init(mainProxy, vkProxy);
		}


		override public function handleNotification(notification:INotification):void {
			super.handleNotification(notification);

			switch (notification.getName()){
				case GeneralAppNotifications.WALL_POST_NOT_SHARED:{
					viewLogic.allowButtonClick();
					break;
				}
			}
		}
		override public function listNotificationInterests():Array {
			return super.listNotificationInterests().concat([
				GeneralAppNotifications.WALL_POST_NOT_SHARED
			]);
		}

		private function get mainProxy():MainProxy {

			return facade.retrieveProxy(MainProxy.NAME) as MainProxy;
		}

		private function get vkProxy():VKAPIProxy {

			return facade.retrieveProxy(VKAPIProxy.NAME) as VKAPIProxy;
		}
	}
}
