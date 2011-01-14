package
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class GameObject extends Sprite
	{
		public var isDead:Boolean = false;
		public var isRemoved:Boolean = false;
		public var type:String = new String;
		private var targetX:Number = 0;
		private var targetY:Number = 0;
		
		public function GameObject()
		{			
			targetX = this.x;
		}	
		
		public function startFollowing(_x:int,_y:int):void
		{
			targetX = _x;	
			targetY = _y;	
		}
		
		public function follow():void
		{
			if(this.x < this.targetX) this.x++;
			else if(this.x > this.targetX) this.x--;
			if(this.y < this.targetY) this.y++;
			else if(this.y > this.targetY) this.y--;
		}
		
		public function stopFollowing():void
		{
			targetX = this.x;
		}
		
		public function updatePosition():void
		{
			follow();	
			if((this.type == "bullet") && this.y < 10)
			{
					GameObjectPool.Instance.Search("bullet").x = -20;
					GameObjectPool.Instance.Search("bullet").y = -20;
					Game.Instance.removeChild(GameObjectPool.Instance.Search("bullet"));
					GameObjectPool.Instance.Objects.pop();
			}		
			else if((this.type == "alien0") ||(this.type == "alien1") ||(this.type == "alien2"))
				if(GameObjectPool.Instance.Search("bullet") != null)
					if(this.hitTestObject(GameObjectPool.Instance.Search("bullet")))
					{
						this.isDead = true;
						GameObjectPool.Instance.Search("bullet").x = -20;
						GameObjectPool.Instance.Search("bullet").y = -20;
						Game.Instance.removeChild(GameObjectPool.Instance.Search("bullet"));
						GameObjectPool.Instance.Objects.pop();
					}
			if((this.type == "alien0") ||(this.type == "alien1") ||(this.type == "alien2"))
				if(this.y >= 300)
					Game.Instance.removeEventListener(Event.ENTER_FRAME,Game.Instance.Loop);				
		}
		
		public function startFire():void
		{
			var object:GameObject = new GameObject();
			object.x = this.x;
			object.y = this.y
			object.type = "bullet";
			object.startFollowing(this.x,0);
			GameObjectPool.Instance.Objects.push(object);
		}
		
		public function stopFire():void
		{
		}
		
	}
}