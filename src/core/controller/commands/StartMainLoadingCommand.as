package core.controller.commands {
    import app.config.GeneralAppNotifications;
    import app.model.proxy.MainProxy;

    import br.com.stimuli.loading.BulkLoader;
    import br.com.stimuli.loading.BulkProgressEvent;

    import core.configs.GeneralNotifications;
    import core.utils.Warehouse;

    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.system.LoaderContext;
    import flash.system.Security;
    import flash.system.SecurityDomain;

    import initialPreLoader.view.InitialPreLoaderMediator;

    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    public class StartMainLoadingCommand extends SimpleCommand {

        private var assetsLoader:BulkLoader;

        private var simple_cache:String = "0001";

        override public function execute(notification:INotification):void {

            var parentUrl:String = notification.getBody() as String;
            var isHTTP:Boolean = parentUrl.charAt(4) == ":";

            initPreLoader();

            initMainLoading(isHTTP);
        }

        private function initMainLoading(isHTTP:Boolean):void {

            Security.loadPolicyFile("http://iieii.pp.ua/crossdomain.xml");

            assetsLoader = new BulkLoader();

            //XMLs:
	        //assetsLoader.add("http://iieii.pp.ua/games/test_on_lanister/res_"+ simple_cache +"/xml/config.xml", {id:"config", preventCache:true});

            var myContext: LoaderContext = new LoaderContext(true, null, SecurityDomain.currentDomain);
            var myContext2: LoaderContext = new LoaderContext(true, null, SecurityDomain.currentDomain);
            var myContext3: LoaderContext = new LoaderContext(true, null, SecurityDomain.currentDomain);

            if (isHTTP){

                Security.allowDomain("*");
                Security.allowInsecureDomain("*");
            }

            //SWF:
            assetsLoader.add("http://iieii.pp.ua/games/test_on_lanister/res_"+ simple_cache +"/swf/mainView.swf", {id:"mainView", context:myContext, preventCache:true} );
            assetsLoader.add("http://api.vk.com/swf/vk_ads.swf", {id:"lib", preventCache:true, context:myContext2} );
            assetsLoader.add("http://ad.mail.ru/static/vkcontainer.swf", {id:"lib", preventCache:true, context:myContext3} );

            assetsLoader.addEventListener(BulkLoader.COMPLETE, onLoadComplete);
            assetsLoader.addEventListener(BulkLoader.PROGRESS, onProgress);
            assetsLoader.start();
        }

        private function onProgress(event:BulkProgressEvent):void {

            sendNotification(GeneralAppNotifications.LOADING_PROGRESS, event.weightPercent);
        }

        private function onLoadComplete(event:Event):void {

            var warehouse:Warehouse = Warehouse.getInstance();

            var view:DisplayObjectContainer = assetsLoader.getMovieClip("mainView");
            warehouse.add(view);
            var xml_config:XML = assetsLoader.getXML("config");

            facade.registerProxy(new MainProxy(xml_config));
            facade.removeMediator(InitialPreLoaderMediator.NAME);

            sendNotification(GeneralNotifications.LOAD_COMPLETE);
        }

        private function initPreLoader():void {

            facade.registerMediator(new InitialPreLoaderMediator());
        }

    }
}
