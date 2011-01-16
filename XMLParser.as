package
{
	import flash.geom.Point;
	public class XMLParser
	{
		private static var _instance:XMLParser = new XMLParser();
		public static function get Instance():XMLParser//делаем синглетон
		{
			trace("getInstance");
			return _instance;
		}	
		public function XMLParser():void
		{
			trace("Constructor");
			if(_instance)
				throw new Error("Use Instance Field");			
		}

		public function GameSetup(xml:XML):void //Настройка с помощью ConfigXML
		{
			Game.Instance.stage.frameRate = xml.FrameRate;
			Game.Instance.stage.stageWidth = xml.Width;
			Game.Instance.stage.stageHeight = xml.Height;
			Game.Instance.stage.nativeWindow.title = xml.Title;				
			Game.Instance.stage.nativeWindow.width = xml.Width;
			Game.Instance.stage.nativeWindow.height = xml.Height;
			var p:Point = new Point(xml.Width,xml.Height);
			Game.Instance.stage.nativeWindow.maxSize = p;
			Game.Instance.stage.nativeWindow.minSize = p;		
		}
		
		public function LevelSetup(xml:XML):void
		{
			for each(var o:XML in xml.set)
			{
				for each(var o1:XML in o.*)
				{
					
					var object:GameObject = new GameObject();
					trace(o1.x);
					object.x = o1.x;
					trace(o.attribute("y"));
					object.y = o.attribute("y");
					object.startFollowing(o1.x,o.attribute("y"));
					trace(o.attribute("type"));
					object.type = o.attribute("type");
					GameObjectPool.Instance.Objects.push(object);
				}
			}		
		}
		
		public function GraphicsPoolSetup(xml:XML):void
		{
			for each(var o:XML in xml.image)
			{
				ResourceLoader.Instance.LoadBitmap(o.url);
			}
		}
	}
}