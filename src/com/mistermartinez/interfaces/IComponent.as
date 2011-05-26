package com.mistermartinez.interfaces
{
	import com.mistermartinez.entities.Entity;

    public interface IComponent
    {
        function get priority():Number;
        function set priority(value:Number):void;
        function get owner():Entity;
        function get name():String;
        function get isRegistered():Boolean;
        function register(owner:Entity, name:String):void;
        function unregister():void;
        //function reset():void;
    }
}