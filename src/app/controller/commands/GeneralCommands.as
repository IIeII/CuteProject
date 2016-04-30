package app.controller.commands {
	import app.config.GeneralAppNotifications;
	import app.view.mediators.ADSMediator;
	import app.view.mediators.LobbyMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class GeneralCommands extends SimpleCommand{

		override public function execute(notification:INotification):void {
			super.execute(notification);

			facade.registerCommand(GeneralAppNotifications.START_TESTING, StartTestingCommand);
			facade.registerCommand(GeneralAppNotifications.SHOW_RESULT, ShowResultCommand);
			facade.registerCommand(GeneralAppNotifications.BACK_TO_LOBBY, BackToLobbyCommand);
			facade.registerMediator(new ADSMediator());
			facade.registerMediator(new LobbyMediator());
		}
	}
}
