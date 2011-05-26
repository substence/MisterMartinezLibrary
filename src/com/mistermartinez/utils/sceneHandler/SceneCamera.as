package com.mistermartinez.utils.sceneHandler
{
	import com.mistermartinez.interfaces.ISpatial;
	import com.mistermartinez.math.Vector2D;
	
	import flash.geom.Rectangle;
	
	public class SceneCamera implements ISpatial
	{
		private var _x:Number;
		private var _y:Number;
		public var bounds:Rectangle;
		public var width:Number;
		public var height:Number;
		public var pixelSnap:Number;
		
		public function SceneCamera(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, bounds:Rectangle = null,  pixelSnap:Number = 0)
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			this.pixelSnap = pixelSnap;
			this.bounds = !bounds ? new Rectangle() : bounds;
		}
		
		public function set rectangle(value:Rectangle):void
		{
			x = value.x;
			y = value.y;
			width = value.width;
			height = value.height;
		}		
		
		public function get rectangle():Rectangle
		{
			return new Rectangle(_x, _y, width, height);
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			if (pixelSnap > 0)
				value = Math.round(value / pixelSnap) * pixelSnap;
			if (bounds)
			{
				value = Math.max(value, bounds.y);				
				if ((value + height) > bounds.bottom)
					value = bounds.bottom - height;
			}
			_y = value;
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			if (pixelSnap > 0)
				value = Math.round(value / pixelSnap) * pixelSnap;
			if (bounds)
			{
				value = Math.max(value, bounds.x);				
				if ((value + width) > bounds.right)
					value = bounds.right - width;
			}			
			_x = value;
		}
		
		public function get position():Vector2D
		{
			return new Vector2D(_x, _y);
		}
		
		public function set position(value:Vector2D):void
		{
			x = value.x;
			y = value.y;
		}

	}
}