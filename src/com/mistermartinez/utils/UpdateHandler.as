package com.mistermartinez.utils{
	import com.mistermartinez.interfaces.IAdvancedUpdatable;
	import com.mistermartinez.interfaces.IUpdatable;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	public class UpdateHandler{
		public static const TICKS_PER_SECOND:int = 30;
		public static const TICK_RATE:Number = 1.0 / TICKS_PER_SECOND;
		public static const TICK_RATE_MS:Number = TICK_RATE * 1000;
		public static const MAX_TICKS_PER_FRAME:int = 10;
		private static var _instance:UpdateHandler = null;
		private var _virtualTime:Number = 0.0;
		private var _interpolationFactor:Number = 0.0;
		private var _timeScale:Number = 1.0;
		private var lastTime:Number = -1.0;
		private var elapsed:Number = 0.0;	
		private var stage:Stage;
		private var isRunning:Boolean = false;
		private var updatees:Vector.<IUpdatable> = new Vector.<IUpdatable>();
		
		public static function initialize(stage:Stage):void
		{
			if(_instance)
				return
			_instance = new UpdateHandler();
			_instance.stage = stage;
			_instance.start();
		}
		
		public static function get instance():UpdateHandler
		{
			if(!_instance)
				throw new Error("You must first initialize UpdateModule");
			return _instance;
		}
		
		public function start():void{
			if (isRunning)
				return;			
			lastTime = -1.0;
			elapsed = 0.0;
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
			isRunning = true;
		}
		
		public function stop():void{
			if (!isRunning)
				return;			
			isRunning = false;
			stage.removeEventListener(Event.ENTER_FRAME, onFrame);
		}		
		
		public function get timeScale():Number{
			return _timeScale;
		}
		
		public function set timeScale(value:Number):void{
			_timeScale = value;
		}
		
		public function get interpolationFactor():Number{
			return _interpolationFactor;
		}
		
		public function get virtualTime():Number{
			return _virtualTime;
		}
		
		public function addUpdatee(updatee:IUpdatable):Boolean{
			for (var i:int = 0; i < updatees.length; ++i){
				if (updatees[i] == updatee)
					return false;				
			}
			updatees.push(updatee);
			return true;
		}
		
		public function removeUpdatee(updatee:IUpdatable):Boolean{
			for (var i:int = 0; i < updatees.length; ++i){
				if (updatees[i] == updatee){
					updatees.splice(i,1);
					return true;
				}
			}
			return false;
		}		
		
		private function onFrame(event:Event):void{            
			// Track current time.
			var currentTime:Number = getTimer();
			if (lastTime < 0)
			{
				lastTime = currentTime;
				return;
			}            
			// Calculate time since last frame and advance that much.
			var deltaTime:Number = Number(currentTime - lastTime) * _timeScale;
			advance(deltaTime);            
			// Note new last time.
			lastTime = currentTime;
		}
		
		private function advance(deltaTime:Number, suppressSafety:Boolean = false):void{
			var startTime:Number = _virtualTime;            
			// Add time to the accumulator.
			elapsed += deltaTime;            
			// Perform ticks, respecting tick caps.
			var tickCount:int = 0;
			while (elapsed >= TICK_RATE_MS && (suppressSafety || tickCount < MAX_TICKS_PER_FRAME)){
				// Ticks always happen on interpolation boundary.
				_interpolationFactor = 0.0;               
				for (var i:int = 0; i < updatees.length; ++i)
				{
					var updatee:IUpdatable = updatees[i];
					if(true)//updatee is IAdvancedUpdatable && elapsed >= (1 - IAdvancedUpdatable(updatee).updateDelay) * 100)
						updatee.update();
				}				
				// Update virtual time by subtracting from accumulator.
				_virtualTime += TICK_RATE_MS;
				elapsed -= TICK_RATE_MS;
				tickCount++;
			}            
			// Safety net - don't do more than a few ticks per frame to avoid death spirals.
			if (tickCount >= MAX_TICKS_PER_FRAME && !suppressSafety)
				elapsed = 0;            
			_virtualTime = startTime + deltaTime;
			_interpolationFactor = elapsed / TICK_RATE_MS;
		}
	}
}