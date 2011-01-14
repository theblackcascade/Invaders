package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	import spark.components.*;
	import spark.components.Window;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			Mouse.hide();
			this.addChild(Game.Instance);
		}

	}
}


