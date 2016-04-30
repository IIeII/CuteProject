package app.controller.commands {
	import app.view.mediators.LevelMediator;
	import app.view.mediators.LobbyMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class StartTestingCommand extends SimpleCommand{

		override public function execute(notification:INotification):void {

			facade.removeMediator(LobbyMediator.NAME);

			facade.registerMediator(new LevelMediator());
		}
	}
}
