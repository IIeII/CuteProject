package app.model.proxy {
	import app.config.GeneralAppNotifications;
	import app.model.vo.DescriptionVO;
	import app.model.vo.QuestionVO;

	import org.puremvc.as3.patterns.proxy.Proxy;

	public class MainProxy extends Proxy{

		public static const NAME:String = "MainProxy";

		private var _score:int;
		private var _currentQuestionIndex:int;

		private var _questions:Vector.<QuestionVO>;
		private var _descriptions:Vector.<DescriptionVO>;
		private var _xml_config:XML;

		public function MainProxy(xml_config:XML) {

			super (NAME);
			_xml_config = xml_config;
			_questions = new Vector.<QuestionVO>();
			_descriptions = new Vector.<DescriptionVO>();

			parseXML();
		}

		private function parseXML():void {

			var questionsXMLList:XMLList = _xml_config.child("QUESTIONS");
			var descriptionsXMLList:XMLList = _xml_config.child("DESCRIPTIONS");

			var i:int;

			for (i = 0; i < questionsXMLList.*.length(); i++ ){

				var question:QuestionVO = new QuestionVO(questionsXMLList.main[i].@QUESTION.toString(),
						                                 questionsXMLList.main[i].@COST.toString());

				_questions.push(question);
			}

			for (i = 0; i < descriptionsXMLList.*.length(); i++ ){

				var description:DescriptionVO = new DescriptionVO(descriptionsXMLList.main[i].@DESCRITION.toString(),
																  descriptionsXMLList.main[i].@COST.toString());

				_descriptions.push(description);
			}
		}

		public function clearData():void {

			_score = 0;
			_currentQuestionIndex = 0;
		}

		public function get score():int {

			return _score;
		}

		public function get currentQuestionText():String {

			return _questions[_currentQuestionIndex].question ;
		}

		public function markCurrentQuestionAsPositive():void {

			_score += _questions[_currentQuestionIndex].cost;
		}

		public function getDescription():String {

			for each (var descriptionVO:DescriptionVO in _descriptions){

				if (descriptionVO.isValueBelongToVO(score)){
					return descriptionVO.description;
				}
			}

			return "ups... no such description";
		}

		public function nextQuestion():void {

			_currentQuestionIndex++;

			if (_currentQuestionIndex < totalQuestionsNumber){
				sendNotification(GeneralAppNotifications.SHOW_QUESTION);
			} else {
				sendNotification(GeneralAppNotifications.SHOW_RESULT);
			}
		}

		public function get totalQuestionsNumber():int {

			return _questions.length;
		}

		public function get currentQuestionIndex():int {
			return _currentQuestionIndex;
		}
	}
}
