package com.mistermartinez.interfaces
{
	import com.mistermartinez.utils.Group;

    public interface IEntity extends IAdvancedUpdatable
    {
		function get group():Group;
        function get name():String;
        function initialize(name:String = null):void;
        function destroy():void;
        function addComponent(component:IComponent, name:String = "", priority:Number = 0):Boolean;
        function removeComponent(component:IComponent):Boolean;
        function getComponentByType(componentType:Class):IComponent;
        //function getAllBehaviorsByType(behaviorType:Class):Vector.<IComponent>;
        function getComponentByName(name:String):IComponent;
    }
}