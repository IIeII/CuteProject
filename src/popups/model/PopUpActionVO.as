package popups.model {
    public class PopUpActionVO {

        public var notificationName:String;
        public var notificationType:String;
        public var notificationBody:Object;
        public var shouldClose:Boolean;

        public function PopUpActionVO(notificationName:String, notificationType:String, notificationBody:Object, shouldClose:Boolean = true) {

            this.notificationName = notificationName;
            this.notificationType = notificationType;
            this.notificationBody = notificationBody;
            this.shouldClose = shouldClose;
        }
    }
}
