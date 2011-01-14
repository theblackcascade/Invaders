package
{
	import flash.display.Bitmap;

	public class GraphicsPool
	{
		public var Graphics:Array = new Array();
		
		private static var _instance:GraphicsPool = new GraphicsPool();
		
		public static function get Instance():GraphicsPool//делаем синглетон
		{
			trace("getInstance");
			return _instance;
		}
		public function GraphicsPool():void
		{
			trace("Constructor");
			if(_instance)
				throw new Error("Use Instance Field");	
		}
		
		public function SearchBitmap(request:String):Bitmap
		{
			var response:GameGraphics;
			for each(var object:GameGraphics in this.Graphics)
			{
				if (object.type == ("app:/"+request+".png"))
				{
					response = object;
					break;
				}
			}
			return response.bitmap;
		}
		
		
		
		
		
	}
}