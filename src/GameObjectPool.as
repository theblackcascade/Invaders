package
{
	import flash.events.Event;
	public class GameObjectPool
	{		
		public var Objects:Array = new Array();
		public var animation:Boolean = true;
		
		private static var _instance:GameObjectPool = new GameObjectPool();
		
		public static function get Instance():GameObjectPool//делаем синглетон
		{
			trace("getInstance");
			return _instance;
		}
		
		public function Search(name:String):GameObject
		{
			var response:GameObject;
			for each(var object:GameObject in Objects)
			{
				if(object.type == name)
				{
					response = object;
					break;
				}
			}
			return response;
		}
		
		public function GameObjectPool():void
		{
			trace("Constructor");
			if(_instance)
				throw new Error("Use Instance Field");		
		}
		
		public function ApplyBitmapData():void
		{
				for each(var object:GameObject in Objects)
				{
					object.graphics.beginBitmapFill(GraphicsPool.Instance.SearchBitmap(object.type).bitmapData);
					object.graphics.drawRect(0,0,GraphicsPool.Instance.SearchBitmap(object.type).width,GraphicsPool.Instance.SearchBitmap(object.type).height);
				}
			Game.Instance.addEventListener(Event.ENTER_FRAME,Game.Instance.Loop);
		}
		
		public function AlternateBitmapData():void
		{
			for each(var object:GameObject in Objects)
			{
				if (!object.isDead)
				{
					if(animation)
					{
						object.graphics.beginBitmapFill(GraphicsPool.Instance.SearchBitmap(object.type).bitmapData);
						object.graphics.drawRect(0,0,GraphicsPool.Instance.SearchBitmap(object.type).width,GraphicsPool.Instance.SearchBitmap(object.type).height);
						animation = false;
					}
					else
					{
						object.graphics.beginBitmapFill(GraphicsPool.Instance.SearchBitmap(object.type+"1").bitmapData);
						object.graphics.drawRect(0,0,GraphicsPool.Instance.SearchBitmap(object.type+"1").width,GraphicsPool.Instance.SearchBitmap(object.type+"1").height);
						animation = true;
					}
				}
				else if(!object.isRemoved)
				{
					object.graphics.beginBitmapFill(GraphicsPool.Instance.SearchBitmap("aliendead").bitmapData);
					object.graphics.drawRect(0,0,GraphicsPool.Instance.SearchBitmap("aliendead").width,GraphicsPool.Instance.SearchBitmap("aliendead").height);
					object.isRemoved = true;
				}
				else
				{
					object.graphics.clear();
					Game.Instance.removeChild(object);
				}
			}
		}
	}
}