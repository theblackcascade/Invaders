package
{
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.ui.KeyboardType;
	
	public class Game extends Sprite
	{
		//debug элементы
		public var score:Number = 0;
		public var anCounter:Number = new Number();
		public var cursor:Sprite = new Sprite();
		public var debugText:TextField = new TextField();
		public var debugHero:GameObject = new GameObject();
		public var debugBackground:Sprite = new Sprite();
		//mustbe
		private static var _instance:Game = new Game();
		public static function get Instance():Game//делаем синглетон
		{
			trace("getInstance");
			return _instance;
		}
		public function Game():void
		{
			trace("Constructor");
			if(_instance)
				throw new Error("Use Instance Field");
			Initialize();			
		}
		
		private function Initialize():void
		{
			trace("initialization");
			
			this.addEventListener(KeyboardEvent.KEY_DOWN,InputManager.Instance.KeyDownListener);
			this.addEventListener(KeyboardEvent.KEY_UP,InputManager.Instance.KeyUpListener);

			ResourceLoader.Instance.LoadXML("Config.xml");
			ResourceLoader.Instance.LoadXML("GraphicsSet.xml");
			ResourceLoader.Instance.LoadXML("Level.xml");
			this.debugBackground.graphics.beginFill(0x000000);
			this.debugBackground.graphics.drawRect(-20,-20,640,480);
			this.debugText = new TextField;
			this.debugText.textColor = 0xFFFFFF;
			this.debugText.x = 0;
			this.debugText.y = 0;
			this.cursor.graphics.beginFill(0xff00ff);
			this.cursor.graphics.drawCircle(1,1,2);
				
		}

		public function Loop(e:Event):void
		{
			this.anCounter++;
			trace("loop");			
			Render();
			InputProcessing();
			AIProcessing();
			SceneUpdate();
			Scoring();
		}

		private function Render():void
		{
			if(anCounter % 100 == 0)
				GameObjectPool.Instance.AlternateBitmapData();
			this.addChild(this.debugBackground);
			this.addChild(this.debugHero);
			this.addChild(this.cursor);
			this.addChild(this.debugText);
			for each(var object:GameObject in GameObjectPool.Instance.Objects)
				this.addChild(object);
			trace("Render");
		}
		
		private function InputProcessing():void
		{
			this.cursor.x = this.stage.mouseX;
			this.cursor.y = this.stage.mouseY;
			trace("Input Processing");
		}
		
		private function AIProcessing():void
		{
			if(anCounter % 200 == 0)
				for each(var obj:GameObject in GameObjectPool.Instance.Objects)
					if(obj.type == "alien1" || obj.type == "alien2" || obj.type == "alien0")
						obj.startFollowing(obj.x,obj.y+5);
			trace("Ai Processing");
		}
				
		private function SceneUpdate():void
		{
			for each(var object:GameObject in GameObjectPool.Instance.Objects)
				object.updatePosition();
			
			
			trace("Scene Update");
		}
		
		private function Scoring():void
		{
			score ++;
			this.debugText.text = this.score.toString();
		}
		
		private function Uninitialize():void
		{
			trace("Uninitialize");
		}
		
		private function Close():void
		{
			trace("bye");				
		};		
	}
}
