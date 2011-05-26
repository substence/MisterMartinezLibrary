package com.mistermartinez.utils{
	import com.mistermartinez.interfaces.IUpdatable;
	import com.mistermartinez.math.Vector2D;
	
	import flash.display.Stage;
	import flash.events.*;
	import flash.geom.Point;
	
	public class InputHandler extends EventDispatcher implements IUpdatable
	{
		public static const MOUSE_SCROLL_UP:String = "mouseScrollUp";
		public static const MOUSE_SCROLL_DOWN:String = "mouseScrollDown";		
		private static var _instance:InputHandler;
		private var _keyStates:Vector.<int> = new Vector.<int>(223,true);	
		private var _mouseState:Number = 0;
		private var _mousePosition:Point = new Point();
		private var _stage:Stage;
		
		public function InputHandler(_singletonEnforcer:singletonEnforcer)
		{
		}		
		
		public function get isMousePressed():Boolean
		{
			return _mouseState == 1;
		}

		public function get isMouseDown():Boolean
		{
			return _mouseState > 0;
		}
		
		public function get isMouseReleased():Boolean
		{
			return _mouseState == -1;
		}		
		
		public function get mousePosition():Vector2D
		{
			return new Vector2D(stage.mouseX, stage.mouseY);			
		}
		
		public function get stage():Stage
		{
			return _stage;
		}		
		
		public static function get instance():InputHandler
		{
			if (!_instance)
				throw new Error("Input Handler must be first initialized.");      		  
			return _instance;				
		}					
		
		public function isKeyDown(keyCode:int):Boolean
		{
			return (_keyStates[keyCode] > 0);
		}
		
		public function areAnyKeysDown(keys:Vector.<int>):Boolean
		{
			for(var i:int =0 ; i < keys.length; ++i)
			{
				if (_keyStates[keys[i]] > 0)
					return true
			}
			return false
		}
		
		public function isKeyPressed(keyCode:int):Boolean
		{
			return _keyStates[keyCode] == 1;
		}
		
		public function areAnyKeysPressed(keys:Vector.<int>):Boolean
		{
			for(var i:int =0 ; i < keys.length; ++i)
			{
				if (_keyStates[keys[i]] == 1)
					return true
			}
			return false
		}							

		public function isKeyReleased(keyCode:int):Boolean
		{
			return (_keyStates[keyCode] == -1);
		}
		
		public function areAnyKeysReleased(keys:Vector.<int>):Boolean
		{
			for(var i:int =0 ; i < keys.length; i++)
			{
				if (_keyStates[keys[i]] == -1)
					return true
			}
			return false
		}			
		
		public function setFocus():void
		{
			_stage.focus = _stage;			
		}			
		
		public function update():void
		{
			_mousePosition.x = _stage.mouseX;
			_mousePosition.y = _stage.mouseY;
			if (_mouseState != 0)
				_mouseState++;			
			for (var i:int = 0; i < _keyStates.length; i++)
			{
				if (_keyStates[i] != 0)
					_keyStates[i]++;
			}						
		}
		
		public function forceClearAllKeys():void
		{
			for (var i:int = 0; i < _keyStates.length; i++)
			{
				_keyStates[i] = 0;
			}	
		}
		
		public static function initialize(stage:Stage):InputHandler
		{		
			if (!_instance){
				_instance = new InputHandler(new singletonEnforcer());
				_instance.setup(stage);
				return _instance;		      						 	
			}
			throw new Error("Input Handler has already been intialized, use 'getInstance()' to reference a local instance.");	      
		}		
		
		private function setup(stage:Stage):void
		{	
			_stage = stage;
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown, false, 1, true);
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyUp, false, 1, true);		
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, false, 0, true);
			_stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp, false, 0, true);
			_stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelChange, false, 0, true);
		}			
		
		private function keyDown(event:KeyboardEvent):void
		{
			_keyStates[event.keyCode] = Math.max(_keyStates[event.keyCode], 1);
			dispatchEvent(event);						
		}		

		private function keyUp(event:KeyboardEvent):void
		{
			_keyStates[event.keyCode] = -1;
			dispatchEvent(event);						
		}		
		
		private function mouseDown(e:MouseEvent):void
		{
			_mouseState = Math.max(_mouseState, 1);
			dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN));
		}
		
		private function mouseUp(e:MouseEvent):void
		{
			_mouseState = -1;
			dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_UP));
		}		
		
		private function mouseWheelChange(event:MouseEvent):void
		{
			if (event.delta > 0)
				dispatchEvent(new Event(MOUSE_SCROLL_UP));
			else
				dispatchEvent(new Event(MOUSE_SCROLL_DOWN))				
		}				
	}
}

class singletonEnforcer{}