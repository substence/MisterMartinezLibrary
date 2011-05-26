package com.mistermartinez.interfaces
{
	import com.mistermartinez.math.Vector2D;

    public interface ISpatial
    {
        function get position():Vector2D;
		function set position(value:Vector2D):void;
    }
}