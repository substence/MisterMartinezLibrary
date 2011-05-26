package com.mistermartinez.interfaces
{
	import flash.geom.Rectangle;
	
	public interface ICollidable
	{
		function get hitBox():Rectangle
		function collided(into:ICollidable):Boolean
	}
}