package core.controller.commands {
    import initialPreLoader.view.InitialPreLoaderMediator;

    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    public class StartMainLoadingCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {

            initPreLoader();

            //initiate main load command

            //initiate lazy load command

        }

        private function initPreLoader():void {

            facade.registerMediator(new InitialPreLoaderMediator());
        }
    }
}
