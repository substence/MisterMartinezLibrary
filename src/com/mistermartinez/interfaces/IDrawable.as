package com.mistermartinez.interfaces
{
    import flash.display.DisplayObject;

    public interface IDrawable
    {
        function get graphic():DisplayObject;
        function set graphic(value:DisplayObject):void;
        function draw():void;
    }
}