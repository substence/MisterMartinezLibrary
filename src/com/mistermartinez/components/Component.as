package com.mistermartinez.components
{
	import com.mistermartinez.entities.Entity;
	import com.mistermartinez.interfaces.IComponent;
	
	public class Component implements IComponent
	{
		protected var _owner:Entity;
		private var _name:String;
		private var _priority:Number = 0;
		
		public function get priority():Number
		{
			return _priority;
		}
		
		public function set priority(value:Number):void
		{
			_priority = value;
		}
		
		public function get owner():Entity
		{
			return _owner;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get isRegistered():Boolean
		{
			return _owner != null;
		}
		
		public function register(owner:Entity, name:String):void
		{
			if (isRegistered)
				trace("WARNING: Trying to register an already-registered behavior");
			_name = name;
			_owner = owner;
			onRegister();
		}
		
		public function unregister():void
		{
			if (!isRegistered)
				trace("WARNING: Trying to unregister an unregistered behavior");
			_owner = null;
			_name = null;
			onUnregister();
		}
		
		virtual protected function onUnregister():void
		{
			
		}
		
		virtual protected function onRegister():void
		{
			
		}
	}
}