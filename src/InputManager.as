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
	public class InputManager// это капец, но я не хотел разрастания game.as
	{
		private var MouseEnabled:Boolean = false; 
		private static var _instance:InputManager = new InputManager();
		public static function get Instance():InputManager//делаем синглетон
		{
			trace("getInstance");
			return _instance;
		}
		public function InputManager():void
		{
			trace("Constructor");
			if(_instance)
				throw new Error("Use Instance Field");		
		}	
		
		public function KeyDownListener(e:KeyboardEvent):void 
		{
			switch(e.keyCode)
			{
				case 90:
					this.toggleInputSource();
					break;
				case 37:
					GameObjectPool.Instance.Search("hero").startFollowing(0,300);
					break;
				case 39:
					GameObjectPool.Instance.Search("hero").startFollowing(490,300);
					break;
				case 32:
					GameObjectPool.Instance.Search("hero").startFire();
					Game.Instance.debugText.text = "Bang!";
					break;
				default:
					break;
			}
		}
		public function KeyUpListener(e:KeyboardEvent):void
		{
			GameObjectPool.Instance.Search("hero").stopFollowing();
			GameObjectPool.Instance.Search("hero").stopFire();
		}
		public function MouseMoveListener(e:MouseEvent):void
		{
			GameObjectPool.Instance.Search("hero").startFollowing(e.stageX,300);
		}		
		public function toggleInputSource():void
		{
			if(MouseEnabled)
			{
				Game.Instance.removeEventListener(MouseEvent.MOUSE_MOVE,MouseMoveListener);
				Game.Instance.removeEventListener(MouseEvent.CLICK,ClickListener);	
				MouseEnabled = false;		
			}
			else
			{
				Game.Instance.addEventListener(MouseEvent.MOUSE_MOVE,MouseMoveListener);
				Game.Instance.addEventListener(MouseEvent.CLICK,ClickListener);
				MouseEnabled = true;
			}
		}
		public function ClickListener(e:MouseEvent):void
		{
			GameObjectPool.Instance.Search("hero").startFire();
		}
	}
}