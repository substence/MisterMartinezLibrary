package com.mistermartinez.utils{
	import flash.events.Event;
	
	public class QuickFrameTimer extends FrameTimer{
		
		public function QuickFrameTimer(steps:int, callBack:Function = null, cycles:int = 1, ... parameters)
		{
			super(steps, cycles);
			_call = callBack;
			_params = parameters;
			start();
		}	
	}
}