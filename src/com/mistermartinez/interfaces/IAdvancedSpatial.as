package com.mistermartinez.interfaces
{
	import com.mistermartinez.math.Vector2D;

	public interface IAdvancedSpatial extends ISpatial
	{
		function get velocity():Vector2D;
		//function set velocity(value:Vector2D):void;
		function get mass():Number;
		function applyForce(force:Vector2D):void
	}
}