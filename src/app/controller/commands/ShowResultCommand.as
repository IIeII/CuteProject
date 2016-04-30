package app.controller.commands {
	import app.view.mediators.LevelMediator;
	import app.view.mediators.ResultMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class ShowResultCommand extends SimpleCommand{

		override public function execute(notification:INotification):void {

			facade.removeMediator(LevelMediator.NAME);
			facade.registerMediator(new ResultMediator());
		}
	}
}
