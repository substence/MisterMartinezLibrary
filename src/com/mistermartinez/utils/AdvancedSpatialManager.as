package com.mistermartinez.utils
{
	import com.mistermartinez.interfaces.IAdvancedSpatial;
	import com.mistermartinez.interfaces.ICollidable;
	import com.mistermartinez.interfaces.IUpdatable;
	import com.mistermartinez.math.Vector2D;
	
	import flash.geom.Rectangle;

	public class AdvancedSpatialManager implements IUpdatable
	{
		private const _AIR_RESISTANCE:Number = .9;
		private var _entities:Vector.<IAdvancedSpatial>;
		private var _collidables:Vector.<ICollidable>;
		public static var instance:AdvancedSpatialManager = new AdvancedSpatialManager();
		
		public function AdvancedSpatialManager()
		{
			_entities = new Vector.<IAdvancedSpatial>();
			_collidables = new Vector.<ICollidable>();
		}
		
		public function addSpatialEntity(entity:IAdvancedSpatial):void
		{
			_entities.push(entity);
			if (entity is ICollidable)
				_collidables.push(entity);
		}
		
		public function removeSpatialEntity(entity:IAdvancedSpatial):void
		{
			var index:int = _entities.indexOf(entity);
			if (index == -1)
				return;			
			_entities.splice(index, 1);
			index = _collidables.indexOf(entity);
			if (index == -1)
				return;
			if (entity is ICollidable)
				_collidables.splice(index, 1);
		}
		
		public function update():void
		{
			checkCollisions();
			updateVelocity();
		}
		
		private function updateVelocity():void
		{
			for (var i:int = 0; i < _entities.length; i++) 
			{
				var entity:IAdvancedSpatial = _entities[i];
				entity.position.add(entity.velocity);
				var resistance:Vector2D = entity.velocity.clone().multiply(-1);
				resistance.length = resistance.length * .1;
				//resistance.length *= entity.damping;
				entity.applyForce(resistance);
			}
		}
		
		private function checkCollisions():void
		{
			var entitiesToCheck:Vector.<ICollidable> = _collidables.slice();//.filter(filterCollidables);
			var length:uint = entitiesToCheck.length;
			for (var i:int = 0; i < length; i++) 
			{
				var a:ICollidable = entitiesToCheck[i];
				for (var j:int = 0; j < length; j++) 
				{
					var b:ICollidable = entitiesToCheck[j];
					if (areRectanglesColliding(a.hitBox, b.hitBox))
					{
						a.collided(b);
						b.collided(a);
					}
				}
				entitiesToCheck.splice(i, 1);
				length = entitiesToCheck.length;
			}
		}
		
/*		private function filterCollidables(item:ISpatial, index:int, vector:Vector.<ISpatial>):Boolean
		{
			return item is ICollidable;
		}*/
		
		private function areRectanglesColliding(a:Rectangle, b:Rectangle):Boolean
		{
			//return a.intersects(b);
			if(Math.abs(a.x - b.x) < a.width + b.width)
			{
				if(Math.abs(a.y - b.y) < a.height + b.height)
					return true;
			}
			return false;
		}
	}
}