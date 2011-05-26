package com.mistermartinez.interfaces
{
	import Box2D.Dynamics.b2Body;

	public interface IBox2D
	{
		function get body():b2Body;
	}
}