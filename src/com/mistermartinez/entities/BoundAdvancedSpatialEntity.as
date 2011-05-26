package com.mistermartinez.entities
{
	import com.mistermartinez.interfaces.IAdvancedSpatial;
	import com.mistermartinez.interfaces.IBound;
	import com.mistermartinez.interfaces.ICollidable;
	import com.mistermartinez.math.Vector2D;
	import com.mistermartinez.utils.AdvancedSpatialManager;
	import com.mistermartinez.utils.sceneHandler.SceneHandler;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	
	public class BoundAdvancedSpatialEntity extends VisibleEntity implements IBound, IAdvancedSpatial
	{
		protected var _damping:Number;
		protected var _velocity:Vector2D;
		protected var _mass:Number;
		protected var _bounds:Rectangle;
		
		public function BoundAdvancedSpatialEntity(graphic:DisplayObject=null, position:Vector2D=null, mass:Number = 0)
		{
			super(graphic, position, name);
			_mass = mass;
			_damping = 1;
			_velocity = new Vector2D();
			AdvancedSpatialManager.instance.addSpatialEntity(this);
			_bounds = SceneHandler.instance.camera.bounds;
		}

		public function get damping():Number
		{
			return _damping;
		}

		public function get mass():Number
		{
			return _mass;
		}

		public function get velocity():Vector2D
		{
			return _velocity;
		}
		
		public function get bounds():Rectangle
		{
			return _bounds;
		}
		
		public function get hitBox():Rectangle
		{
			if (!_graphic)
				return new Rectangle();
			const HALF_WIDTH:Number = _graphic.width * .5;
			const HALF_HEIGHT:Number = _graphic.height * .5;
			return new Rectangle(_position.x, _position.y, HALF_WIDTH, HALF_HEIGHT);
		}
		
		public function applyForce(force:Vector2D):void
		{
			force.length *= _mass;
			_velocity.add(force);
		}
		
		public function collided(into:ICollidable):Boolean
		{
			return false;
		}
		
		override public function update():void
		{
			super.update();
		}
		
		override public function destroy():void
		{
			super.destroy();
			AdvancedSpatialManager.instance.removeSpatialEntity(this);
		}

	}
}