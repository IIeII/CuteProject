package core.controller.commands {
    import app.config.GeneralAppNotifications;
    import app.controller.commands.GeneralCommands;
    import app.view.mediators.LobbyMediator;

    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    public class LoadCompleteCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {

            facade.registerCommand(GeneralAppNotifications.REGISTER_GENERAL_COMMANDS, GeneralCommands);
            sendNotification(GeneralAppNotifications.REGISTER_GENERAL_COMMANDS);
        }
    }
}
