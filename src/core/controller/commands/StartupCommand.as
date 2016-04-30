package core.controller.commands {
    import app.model.proxy.VKAPIProxy;

    import core.configs.GeneralNotifications;
    import core.model.KeyBoardProxy;
    import core.view.mediators.RootMediator;

    import flash.display.Sprite;

    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    public class StartupCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {

            var root:Sprite = notification.getBody() as Sprite;

            facade.registerCommand(GeneralNotifications.START_LOADING_RESOURCES, StartMainLoadingCommand);
            facade.registerCommand(GeneralNotifications.LOAD_COMPLETE, LoadCompleteCommand);

            facade.registerProxy(new KeyBoardProxy(root));
            facade.registerProxy(new VKAPIProxy(root.stage.loaderInfo.parameters as Object));
            facade.registerMediator(new RootMediator(root));

            sendNotification(GeneralNotifications.START_LOADING_RESOURCES, root.loaderInfo.url);
        }
    }
}
