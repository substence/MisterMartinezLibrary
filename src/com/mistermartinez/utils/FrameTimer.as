package com.mistermartinez.utils{
	import com.mistermartinez.interfaces.IUpdatable;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class FrameTimer extends EventDispatcher implements IUpdatable
	{
		public static const CYCLE_COMPLETE:String = "frameCycleComplete";
		public static const TIMER_COMPLETE:String = "frameTimerComplete";
		public static const TIMER_START:String = "frameTimerStart";	
		public static const TIMER_STOP:String = "frameTimerStop";
		protected var _call:Function;
		protected var _params:Array;		
		private var _steps:int;
		private var _cycles:int;
		private var _step:int;
		private var _cycle:int;
		private var _isRunning:Boolean;
		private var _isPaused:Boolean;
		
		public function FrameTimer(steps:int = 0, cycles:int = 1, callBack:Function = null, ... parameters)
		{
			_steps = steps;
			_cycles = cycles;
			_step = 0;
			_cycle = 0;
			_call = callBack;
			_params = parameters;
			_isRunning = false;
			_isPaused = false;
		}
		
		public function get isComplete():Boolean
		{
			return _cycle >= _cycles;
		}
		
		public function get isPaused():Boolean
		{
			return _isPaused;
		}
		
		public function set isPaused(value:Boolean):void
		{
			_isPaused = value;				
			if(value && _isRunning){
				stop();			
			}else if (!value && !_isRunning){				
				start();
			}			
		}
		
		public function get steps():int
		{
			return _steps;
		}

		public function set steps(value:int):void
		{
			_steps = value;
		}	

		public function get cycles():int
		{
			return _cycles;
		}
		
		public function set cycles(cycles:int):void
		{
			_cycles = cycles;
		}			
		
		public function get cycle():int
		{
			return _cycle;
		}

		public function set cycle(value:int):void
		{
			_cycle = value;
		}
	
		public function get isRunning():Boolean
		{
			return _isRunning;
		}
		
		public function setCallBack(call:Function, ... parameters):void
		{
			_call = call;
			_params = parameters;
		}
		
		public function reset():void
		{
			_step = 0;
			_cycle = 0;
		}
				
		public function start():void
		{
			if(_isRunning || _isPaused)
				return;
			_isRunning = true;
			dispatchEvent(new Event(TIMER_START));	
			UpdateHandler.instance.addUpdatee(this);
		}
		
		public function stop():int
		{
			if(!isRunning)
				return 0;
			_isRunning = false;
			dispatchEvent(new Event(TIMER_STOP));
			UpdateHandler.instance.removeUpdatee(this);
			return _cycle;				
		}		
		
		public function forceComplete():void
		{
			timerComplete();
		}
		
		public function update():void
		{
			_step++;
			if(_step >= _steps)
				cycleComplete();
		}		
		
		private function cycleComplete():void
		{
			_step = 0;
			_cycle++;
			dispatchEvent(new Event(CYCLE_COMPLETE));
			if(_cycle >= _cycles)
				timerComplete();
		}
		
		protected function timerComplete():void
		{
			if(_call != null)
			{
				if(_params.length > 0)
					_call.apply(null, _params);
				else
					_call();
			}
			_call = null;
			_params = null;				
			stop();
			dispatchEvent(new Event(TIMER_COMPLETE));			
		}
	}
}