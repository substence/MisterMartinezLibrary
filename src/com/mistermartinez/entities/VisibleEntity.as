package com.mistermartinez.entities
{
	import com.mistermartinez.interfaces.IDrawable;
	import com.mistermartinez.interfaces.ISpatial;
	import com.mistermartinez.math.Vector2D;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.sampler._getInvocationCount;
	
	public class VisibleEntity extends Entity implements IDrawable, ISpatial
	{
		protected var _graphic:DisplayObject;
		protected var _position:Vector2D;
		
		public function VisibleEntity(graphic:DisplayObject = null, position:Vector2D = null, name:String = null)
		{
			_graphic = graphic;
			if (!position)
				position = new Vector2D();
			_position = position;
			initialize(name);
		}
		
		public function get graphic():DisplayObject
		{
			return _graphic;
		}
		
		public function set graphic(value:DisplayObject):void
		{
			_graphic = value;
		}
		
		public function get position():Vector2D
		{
			return _position;
		}
		
		public function set position(value:Vector2D):void
		{
			_position = value;
		}
		
		override public function update():void
		{
			draw(); //we'll leave this here for now
			super.update();
		}
		
		public function draw():void
		{
			if (_graphic)
			{
				_graphic.x = _position.x;
				_graphic.y = _position.y;
			}
		}
	}
}