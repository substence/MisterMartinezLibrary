package com.mistermartinez.interfaces
{
	import flash.display.DisplayObject;

	public interface IUserInterface extends IUpdatable
	{
		function added():void;
		function removed():void;
		function get graphic():DisplayObject;
	}
}