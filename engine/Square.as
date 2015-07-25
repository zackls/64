package 
{
	import flash.display.*;
	import flash.filters.BlurFilter;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform

	public class Square extends Sprite
	{
		public var piece:Sprite;
		public var displayInfo:Boolean = false;
		public var holdingPiece:Sprite
		public var transformer:ColorTransform = new ColorTransform()
		public var inFrontContainer:Sprite = new Sprite()
		public var inBackContainer:Sprite = new Sprite()
		public var trap:Boolean = false
		public var trapDamage:int = 0
		public var trapOwner:Sprite
		private var colorContainer:Sprite = new Sprite();
		private var filter:BlurFilter;
		public function Square()
		{
			var a:Sprite = new whiteSquare();
			addChild(a);
			a.width = 500 / 3;
			a.height = 500 / 3;
			a.alpha = 0;
			filter = new BlurFilter(3,3,1);
			colorContainer.filters = [filter];
			addChild(colorContainer);
			addChild(inBackContainer)
			addChild(inFrontContainer)
		}
		public function IlluminatePurple():void
		{
			colorContainer.graphics.beginFill(0x660198, 0.9);
			colorContainer.graphics.drawRect(-260 / 3, -260 / 3, 520 / 3, 520 / 3);
			colorContainer.graphics.endFill();
		}
		public function IlluminateGreen():void
		{
			colorContainer.graphics.beginFill(0x009900, 0.75);
			colorContainer.graphics.drawRect(-260 / 3, -260 / 3, 520 / 3, 520 / 3);
			colorContainer.graphics.endFill();
		}
		public function IlluminateRed():void
		{
			colorContainer.graphics.beginFill(0xFF0000, 0.75);
			colorContainer.graphics.drawRect(-260 / 3, -260 / 3, 520 / 3, 520 / 3);
			colorContainer.graphics.endFill();
		}
		public function IlluminateBlue():void
		{
			displayInfo = true;
			colorContainer.graphics.beginFill(0x00CCCC, 0.75);
			colorContainer.graphics.drawRect(-260 / 3, -260 / 3, 520 / 3, 520 / 3);
			colorContainer.graphics.endFill();
		}
		public function IlluminateYellow():void
		{
			displayInfo = true;
			colorContainer.graphics.beginFill(0xFFFF33, 0.8);
			colorContainer.graphics.drawRect(-260 / 3, -260 / 3, 520 / 3, 520 / 3);
			colorContainer.graphics.endFill();
		}
		public function IlluminateOrange():void
		{
			colorContainer.graphics.beginFill(0xFF6600, 0.8);
			colorContainer.graphics.drawRect(-260 / 3, -260 / 3, 520 / 3, 520 / 3);
			colorContainer.graphics.endFill();
		}
		public function IlluminateLightGreen():void
		{
			filter = new BlurFilter(30,30,1)
			colorContainer.filters = [filter]
			colorContainer.graphics.beginFill(0x009900, 0.7);
			colorContainer.graphics.drawRect(-210 / 3, -210 / 3, 420 / 3, 420 / 3);
			colorContainer.graphics.endFill();
		}
		public function IlluminateLightRed():void
		{
			filter = new BlurFilter(30,30,1)
			colorContainer.filters = [filter]
			colorContainer.graphics.beginFill(0xFF0000, 0.7);
			colorContainer.graphics.drawRect(-210 / 3, -210 / 3, 420 / 3, 420 / 3);
			colorContainer.graphics.endFill();
		}
		public function Dilluminate():void
		{
			filter = new BlurFilter(3,3,1)
			colorContainer.filters = [filter]
			displayInfo = false;
			colorContainer.graphics.clear();
			colorContainer.graphics.beginFill(0x000000, 0.01);
			colorContainer.graphics.drawRect(-250 / 3, -250 / 3, 500 / 3, 500 / 3);
			colorContainer.graphics.endFill();
		}
	}
}