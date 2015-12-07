package initialPreLoader.view {
    import core.view.components.ViewLogic;

    import flash.display.Graphics;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;

    public class InitialPreLoaderViewLogic extends ViewLogic {

	    private const _color:uint = 0xFF6633;
	    private const _radiusOfPreLoader:int = 25;
	    private const _minRadiusOfSegment:int = 3;
	    private const _maxRadiusOfSegment:int = 7;
	    private const _maxAlphaOfSegment:Number = 0.6;
	    private const _minAlphaOfSegment:Number = 0.2;
	    private const _speed:int = 15;
	    private const _numOfSegments:int = 7;

        private var _preLoaderAnimationContainer:Sprite;
        private var _textFieldForPercents:TextField;

        public function init():void {

            initPreLoaderAnimation();
            initPreLoaderTextField();

            content.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

	    private function initPreLoaderTextField():void {

            _textFieldForPercents = new TextField();

            content.addChild(_textFieldForPercents);

            _textFieldForPercents.text = "0%";
            _textFieldForPercents.selectable = false;
            _textFieldForPercents.autoSize = TextFieldAutoSize.CENTER;
            _textFieldForPercents.x = (content.parent.stage.stageWidth - _textFieldForPercents.width) / 2;
            _textFieldForPercents.y = (content.parent.stage.stageHeight - _textFieldForPercents.height) / 2;
        }

        private function initPreLoaderAnimation():void {

            _preLoaderAnimationContainer = new Sprite();

            content.addChild(_preLoaderAnimationContainer);

            _preLoaderAnimationContainer.x = content.parent.stage.stageWidth / 2;
            _preLoaderAnimationContainer.y = content.parent.stage.stageHeight / 2;

            drawPreLoaderAnimation();
        }

        private function drawPreLoaderAnimation():void {

            for(var i:int = 0; i < _numOfSegments; i++) {
                var angleInDegrees:Number = 360 / _numOfSegments * i;
                var angleInRadians:Number = angleInDegrees * Math.PI / 180;

                var segment:Shape = getShape(i);

                segment.x = Math.cos(angleInRadians) * _radiusOfPreLoader;
                segment.y = Math.sin(angleInRadians) * _radiusOfPreLoader;

                _preLoaderAnimationContainer.addChild(segment);
            }
        }

        private function getShape(indexOfSegment:int):Shape {

            var stepOfRadius:Number = (_maxRadiusOfSegment - _minRadiusOfSegment) / (_numOfSegments - 1);
            var stepOfAlpha:Number = (_maxAlphaOfSegment - _minAlphaOfSegment) / (_numOfSegments - 1);
            var currentAlpha:Number = stepOfAlpha * indexOfSegment + _minAlphaOfSegment;
            var currentRadius:Number = stepOfRadius * indexOfSegment + _minRadiusOfSegment;

            var shape:Shape = new Shape();

            var graphics:Graphics = shape.graphics;
            graphics.beginFill(_color, currentAlpha);
            graphics.drawCircle(0, 0, currentRadius);
            graphics.endFill();

            return shape;
        }

        private function onEnterFrame(event:Event):void {

            _preLoaderAnimationContainer.rotation += _speed;
        }

        public function updateFieldForPercents(value:int):void {

            _textFieldForPercents.text = value.toString() + "%";
        }
        
        public function destroy():void {

            content.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            content.parent.removeChild(content);
        }
    }
}
