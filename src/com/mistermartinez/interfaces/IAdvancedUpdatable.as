package com.mistermartinez.interfaces
{
	public interface IAdvancedUpdatable extends IUpdatable
	{
		function get updateDelay():Number;
		function set updateDelay(value:Number):void;
		function get isPaused():Boolean;
	}
}