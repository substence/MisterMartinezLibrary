package com.mistermartinez.utils.sceneHandler
{
	import flash.display.Sprite;	
	
	public class SceneLayer
	{					
		public var index:int;
		public var damping:Number;		
		public var canvas:Sprite;		
		
		public function SceneLayer(index:int = 0, damping:Number = 1, canvas:Sprite = null)
		{
			this.damping = damping;
			this.canvas = !canvas ? new Sprite() : canvas;
			this.index = index;
		}
		
		public function clearCanvas():void
		{
			canvas = new Sprite();
		}
		
	}
}