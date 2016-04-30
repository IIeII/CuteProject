package initialPreLoader.view {
	import app.config.GeneralAppNotifications;

	import core.view.mediators.UIBaseMediator;

	import org.puremvc.as3.interfaces.INotification;

	public class InitialPreLoaderMediator extends UIBaseMediator {

		public static const NAME:String = "InitialPreLoaderMediator";

		private var viewLogic:InitialPreLoaderViewLogic;

		public function InitialPreLoaderMediator() {

			viewLogic = new InitialPreLoaderViewLogic();
			super(NAME, viewLogic);
		}

		override public function onRegister():void {
			super.onRegister();
			viewLogic.init();
		}

		override public function onRemove():void {
			super.onRemove();
			viewLogic.destroy();
		}

		override public function listNotificationInterests():Array {
			return super.listNotificationInterests().concat([
				GeneralAppNotifications.LOADING_PROGRESS
			]);
		}

		override public function handleNotification(notification:INotification):void {
			super.handleNotification(notification);
			switch (notification.getName()){
				case GeneralAppNotifications.LOADING_PROGRESS:
					viewLogic.updateFieldForPercents((notification.getBody() as Number)*100);
					break;
			}

		}
	}
}
