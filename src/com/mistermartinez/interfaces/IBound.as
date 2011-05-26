package com.mistermartinez.interfaces
{
	import flash.geom.Rectangle;

	public interface IBound extends ICollidable
	{
		function get bounds():Rectangle;
	}
}