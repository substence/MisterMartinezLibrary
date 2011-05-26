package com.mistermartinez.entities
{
    import com.mistermartinez.interfaces.*;
    import com.mistermartinez.utils.Group;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    
    public class Entity extends EventDispatcher implements IEntity, IEventDispatcher
    {
        public static const ENTITY_DESTROYED:String = "entityDestroyed";
        protected var _components:Vector.<IComponent> = new Vector.<IComponent>();
		protected var _name:String;
		protected var _updateDelay:Number;
		protected var _group:Group;
		
		public function set updateDelay(value:Number):void
		{
			_updateDelay = value;
		}
		
		public function get group():Group
		{
			return _group;
		}

		public function get updateDelay():Number
		{
			return _updateDelay;
		}
		
		public function get isPaused():Boolean
		{
			return _updateDelay == 0;
		}

        public function get name():String
        {
            return _name;
        }

        public function initialize(name:String = null):void
        {
            _name = name;
        }

        public function destroy():void
        {
            dispatchEvent(new Event(ENTITY_DESTROYED));
            // EntityNames.removeEntity(this);
            _name = null;
            for (var i:int = 0; i < _components.length; ++i)
            {
                _components[i].unregister();
				_components.splice(i, 1);
            }
        }

        public function addComponent(behavior:IComponent, name:String = "", priority:Number = 0):Boolean
        {
            if (behavior.owner || getComponentByName(name) != null)
                return false;
            if (name == "" || name == null)
                name = String(behavior);
            var position:int = -1;
            for (var i:int = 0; i < _components.length; ++i)
            {
                if (_components[i].priority < priority)
                {
                    position = i;
                    break;
                }
            }
            if (position < 0 || position >= _components.length)
                _components.push(behavior);
            else
                _components.splice(position, 0, behavior);
            behavior.register(this, name);
            return true;
        }

        public function removeComponent(behavior:IComponent):Boolean
        {
            if (!behavior.isRegistered || behavior.owner != this)
                return false;
            var index:int = _components.indexOf(behavior);
            if (index < 0)
                return false
            behavior.unregister();
            _components.splice(index, 1);
            return true;
        }

        public function getComponentByType(behaviorType:Class):IComponent
        {
            for (var i:int = 0; i < _components.length; ++i)
            {
                if (_components[i] is behaviorType)
                    return _components[i];
            }
            return null;
        }

        public function getAllBehaviorsByType(behaviorType:Class):Vector.<IComponent>
        {
            var behaviorsOfType:Vector.<IComponent> = new Vector.<IComponent>();
            for (var i:int = 0; i < _components.length; ++i)
            {
                if (_components[i] is behaviorType)
                    behaviorsOfType.push(_components[i]);
            }
            return behaviorsOfType;
        }

        public function getComponentByName(name:String):IComponent
        {
            for (var i:int = 0; i < _components.length; ++i)
            {
                if (_components[i].name == name)
                    return _components[i];
            }
            return null;
        }

        override public function toString():String
        {
            return "<Entity: name = " + _name + ">";
        }

        public function update():void
        {
			for (var i:int = 0; i < _components.length; ++i)
			{
				var behavior:IComponent = _components[i];
				if (behavior is IUpdatable)
					IUpdatable(behavior).update();
			}			
        }
    }
}