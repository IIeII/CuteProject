package app.view.mediators {
	import app.model.proxy.VKAPIProxy;
	import app.view.components.ADSViewLogic;

	import core.view.mediators.UIBaseMediator;

	public class ADSMediator extends UIBaseMediator{

		public static const NAME:String = "ADSMediator";

		private var viewLogic:ADSViewLogic;

		public function ADSMediator() {

			viewLogic = new ADSViewLogic();

			super (NAME, viewLogic);
		}

		override public function onRegister():void {
			super.onRegister();
			viewLogic.init((facade.retrieveProxy(VKAPIProxy.NAME) as VKAPIProxy).flashVars);
		}
	}
}
