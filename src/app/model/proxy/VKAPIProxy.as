package app.model.proxy {
	import app.config.GeneralAppNotifications;

	import flash.events.Event;
	import flash.utils.ByteArray;

	import org.puremvc.as3.patterns.proxy.Proxy;

	import ru.inspirit.net.MultipartURLLoader;

	import vk.APIConnection;
	import vk.events.CustomEvent;

	public class VKAPIProxy extends Proxy{

		public static const NAME:String = "VKAPIProxy";

		private var VK:APIConnection;
		private  var someByteArray:ByteArray;
		public var userGender:int;

		private var _flashVars:Object;

		public function VKAPIProxy(flashVars:Object) {

			super (NAME);

			_flashVars = flashVars;

			initAPIConnection();
		}

		private function initAPIConnection():void {

			VK = new APIConnection(_flashVars);

			VK.addEventListener('onConnectionInit', onConnectionInit);

			VK.addEventListener('onWindowBlur', function(): void{
				trace("Window blur\n");
			});
			VK.addEventListener('onWindowFocus', function(): void{
				trace("Window focus\n");
			});
			VK.addEventListener('onApplicationAdded', function(): void{
				trace("Application added\n");
			});
			VK.addEventListener('onBalanceChanged', function(e:CustomEvent): void{
				trace("Balance changed: "+e.params[0]+"\n");
			});
			VK.addEventListener('onSettingsChanged', function(e:CustomEvent): void{
				trace("Settings changed: "+e.params[0]+"\n");
			});
			VK.addEventListener('onMerchantPaymentFail', function(e:CustomEvent): void{
				trace("Payment fail: "+e.params[0]+"\n");
			});
			VK.addEventListener('onMerchantPaymentSuccess', function(e:CustomEvent): void{
				var msg: String = "Successfull payment.";
				if (e.params[0]) {
					msg += " Order ID: " + e.params[0];
				}
				trace(msg + "\n");
			});
			VK.addEventListener('onMerchantPaymentCancel', function(): void{
				trace("Payment cancelled\n");
			});
		}

		private function onConnectionInit(event:Event):void {

			trace("onConnectionInit");
			getUserInfo();
		}

		private function getUserInfo():void {

			VK.api('users.get',{fields:"sex"}, onGetUserInfo, onGetUserInfoError);
		}

		private function onGetUserInfo(data: Object):void {

			userGender = data[0].sex;
			if (userGender == 0){
				userGender++;
			}
		}

		private function onGetUserInfoError(data: Object):void {

			trace(data);
		}

		public function postImageOnWall(image:ByteArray):void {

			someByteArray = image;
			VK.api('photos.getWallUploadServer',{}, onPostImageOnWall, onPostImageOnWallError);
		}

		private function onPostImageOnWall(data: Object):void {

			var mll:MultipartURLLoader = new MultipartURLLoader();
			mll.addEventListener(Event.COMPLETE, onUploadCompleteThroughAlarm);
			mll.addFile(someByteArray, "file.jpg", "file1", 'image/jpg');
			mll.load(data.upload_url);
		}

		private function onUploadCompleteThroughAlarm(event:Event):void {

			var answer:String = (event.target as MultipartURLLoader).loader.data;
			var data:Object = JSON.parse(answer);

			VK.api('photos.saveWallPhoto', {server:data.server, photo:data.photo, hash:data.hash }, onSaveWallPhoto, onPostImageOnWallError);
		}

		private function onSaveWallPhoto(data:Object):void {

			VK.api('wall.post', { message: 'https://vk.com/app3930638', attachments: data[0].id}, wallPostSuccess, wallPostFail);
		}

		private function onPostImageOnWallError(data: Object):void {

			sendNotification(GeneralAppNotifications.BACK_TO_LOBBY);
		}

		private function wallPostFail(data:Object):void {

			sendNotification(GeneralAppNotifications.WALL_POST_NOT_SHARED);
			trace("wallPostFail");
		}

		private function wallPostSuccess(data:Object):void {

			sendNotification(GeneralAppNotifications.BACK_TO_LOBBY);
			trace("wallPostSuccess");
		}

		public function get flashVars():Object {
			return _flashVars;
		}
	}
}
