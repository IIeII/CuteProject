package core.utils {
    import flash.display.DisplayObjectContainer;

    public class Warehouse {

        private var warehouse:Array;
        private static var instance:Warehouse;

        public function Warehouse() {

            warehouse = [];
        }

        public static function getInstance():Warehouse {

            if(instance == null) {
                instance = new Warehouse();
            }
            return instance as Warehouse;
        }

        public function add(content:DisplayObjectContainer):void {

            warehouse.push(content);
        }

        public function getClassByLinkage(name:String):DisplayObjectContainer {

            var item:Class = null;
            var viewContainer:DisplayObjectContainer;
            for each(viewContainer in warehouse) {
                if(viewContainer.loaderInfo.applicationDomain.hasDefinition(name)) {
                    item = viewContainer.loaderInfo.applicationDomain.getDefinition(name) as Class;
                    var example:DisplayObjectContainer = new item();
                    break;
                }
            }
            return example;
        }
    }
}

