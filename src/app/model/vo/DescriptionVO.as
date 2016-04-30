package app.model.vo {
	public class DescriptionVO {

		private var _description:String;

		private var minBorder:int;
		private var maxBorder:int;

		public function DescriptionVO(description:String, cost:String) {

			this._description = description;

			defineCostBorders(cost);
		}

		private function defineCostBorders(cost:String):void {

			var borders:Array = cost.split("..");
			minBorder = borders[0];
			maxBorder = borders[1];
		}

		public function isValueBelongToVO(value:int):Boolean {

			return (value >= minBorder) && (value <= maxBorder);
		}

		public function get description():String {

			return _description;
		}
	}
}
