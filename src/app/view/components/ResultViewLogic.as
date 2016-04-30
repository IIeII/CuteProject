package app.view.components {
	import app.model.proxy.MainProxy;
	import app.model.proxy.VKAPIProxy;

	import core.view.components.ViewLogic;

	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.ByteArray;

	import mx.graphics.codec.JPEGEncoder;

	public class ResultViewLogic extends ViewLogic{

		private var result:TextField;
		private var description:TextField;
		private var share:SimpleButton;

		private var mainProxy:MainProxy;
		private var vkProxy:VKAPIProxy;

		public const EVENT_TEST_PASSED:String = "eventTestPassed";

		public function ResultViewLogic(linkage:String) {

			super (linkage);
		}

		public function init(mainProxy:MainProxy, vkProxy:VKAPIProxy):void {
			this.mainProxy = mainProxy;
			this.vkProxy = vkProxy;

			(content as MovieClip).gotoAndStop(vkProxy.userGender);

			result = content["result"] as TextField;
			description = content["description"] as TextField;
			share = content["share"] as SimpleButton;
			share.addEventListener(MouseEvent.CLICK, onShareButtonClicked);

			setText();
		}

		private function onShareButtonClicked(event:Event):void {

			share.enabled = false;
			share.removeEventListener(MouseEvent.CLICK, onShareButtonClicked);

			var bd : BitmapData = new BitmapData( content.width, content.height );

			bd.draw( content );

			var JPEGEnc:JPEGEncoder = new JPEGEncoder();

			var png_image_data:ByteArray = JPEGEnc.encode(bd);
			vkProxy.postImageOnWall(png_image_data);
		}

		public function allowButtonClick():void {

			share.enabled = true;
			share.addEventListener(MouseEvent.CLICK, onShareButtonClicked);
		}

		private function setText():void {

			result.text = (mainProxy.score / 10).toString() + "%";
			description.text = mainProxy.getDescription();
 		}
	}
}
