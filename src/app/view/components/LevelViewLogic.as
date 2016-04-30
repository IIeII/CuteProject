package app.view.components {
	import app.model.proxy.MainProxy;

	import core.view.components.ViewLogic;

	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import flash.text.TextField;

	public class LevelViewLogic extends ViewLogic{

		public static const EVENT_YES_BUTTON_CLICKED:String = "yesButtonClicked";
		public static const EVENT_NO_BUTTON_CLICKED:String = "noButtonClicked";

		private var mainProxy:MainProxy;

		private var question_text:TextField;
		private var current_counter:TextField;
		private var total_counter:TextField;

		private var yes_button:SimpleButton;
		private var no_button:SimpleButton;

		public function LevelViewLogic(linkage:String) {

			super(linkage);
		}

		public function init(mainProxy:MainProxy):void {
			this.mainProxy = mainProxy;

			question_text = content["question"] as TextField;
			current_counter = content["current"] as TextField;
			total_counter = content["total"] as TextField;

			yes_button = content["yes_button"] as SimpleButton;
			no_button = content["no_button"] as SimpleButton;

			yes_button.addEventListener(MouseEvent.CLICK, onYesButtonClicked);
			no_button.addEventListener(MouseEvent.CLICK, onNoButtonClicked);

			setQuestion();
		}

		private function onYesButtonClicked(event:Event):void {

			dispatchEvent(new Event(EVENT_YES_BUTTON_CLICKED));
		}

		private function onNoButtonClicked(event:Event):void {

			dispatchEvent(new Event(EVENT_NO_BUTTON_CLICKED));
		}

		public function setQuestion():void {

			question_text.text = mainProxy.currentQuestionText;
			current_counter.text = (mainProxy.currentQuestionIndex + 1).toString();
			total_counter.text = mainProxy.totalQuestionsNumber.toString();
		}
	}
}