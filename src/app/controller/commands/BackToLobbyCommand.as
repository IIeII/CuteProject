package app.controller.commands {
	import app.model.proxy.MainProxy;
	import app.view.mediators.LobbyMediator;
	import app.view.mediators.ResultMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class BackToLobbyCommand extends SimpleCommand{

		override public function execute(notification:INotification):void {

			facade.removeMediator(ResultMediator.NAME);
			mainProxy.clearData();
			facade.registerMediator(new LobbyMediator());
		}

		private function get mainProxy():MainProxy {

			return facade.retrieveProxy(MainProxy.NAME) as MainProxy;
		}
	}
}
