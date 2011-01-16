package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class ResourceLoader
	{
		private var urlLoaderList:Array = new Array();
		private var bmpLoaderList:Array = new Array();
		private var urlLoader:URLLoader = new URLLoader();
		private var bmpLoader:Loader = new Loader();
		private var xml:XML = new XML();
		private var bitmap:Bitmap = new Bitmap();
		private var xmlCounter:int = 0;
		private var bmpCounter:int = 0;
		
		private static var _instance:ResourceLoader = new ResourceLoader();
		
		public static function get Instance():ResourceLoader//делаем синглетон
		{
			trace("getInstance");
			return _instance;
		}
		public function ResourceLoader()
		{			
			trace("ResourceConstructor");
			if(_instance)
				throw new Error("Use Instance Field");
		}

		public function LoadXML(URL:String):void
		{
			xmlCounter++;
			this.urlLoaderList[xmlCounter] = new URLLoader();
			this.urlLoaderList[xmlCounter].addEventListener(Event.COMPLETE,XmlLoadCompleteListener);
			this.urlLoaderList[xmlCounter].load(new URLRequest(URL));			
		}
		private function XmlLoadCompleteListener(e:Event):void
		{
			var xml:XML = new XML(e.target.data);
			trace(xml);
			trace(xml.name());
			if(xml.name() == "Config")
					XMLParser.Instance.GameSetup(xml);
			else if(xml.name() == "GraphicsSet")
					XMLParser.Instance.GraphicsPoolSetup(xml);// заполняем пул графикой(pool)
			else if (xml.name() == "Level")
					XMLParser.Instance.LevelSetup(xml);//Заполняем коллекцию объектов(assets)
			else
					throw new Error("i do not know this");			
			urlLoader.removeEventListener(Event.COMPLETE,XmlLoadCompleteListener);
		}			

		public function LoadBitmap(URL:String):void
		{	
			bmpCounter++;
			this.bmpLoaderList[bmpCounter] = new Loader();
			this.bmpLoaderList[bmpCounter].contentLoaderInfo.addEventListener(Event.INIT,BitmapLoaderInitListener);
			this.bmpLoaderList[bmpCounter].load(new URLRequest(URL));
		}
		
		private function BitmapLoaderInitListener(e:Event):void
		{
			
			trace("IN BITMAP LOADER");
			var content:GameGraphics = new GameGraphics;
			content.bitmap = Bitmap(e.target.content);
			content.type = e.target.url;
			GraphicsPool.Instance.Graphics.push(content);
			if(GraphicsPool.Instance.Graphics.length == bmpCounter)
				GameObjectPool.Instance.ApplyBitmapData();	
		}
	}
}