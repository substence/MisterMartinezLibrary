package com.mistermartinez.utils
{
	import com.mistermartinez.interfaces.IUpdatable;
	import com.mistermartinez.interfaces.IUserInterface;
	
	import flash.display.Sprite;
	
	public class UIHandler implements IUpdatable
	{
		private static var _instance:UIHandler;
		private var _container:Sprite;
		private var _screens:Vector.<IUserInterface>;
		
		public static function get instance():UIHandler
		{
			if (!_instance)
				throw new Error("You must must initialize.");
			return _instance;
		}

		public static function initialize():void
		{
			if (_instance)
				throw new Error("Already initialized.");
			else
				_instance = new UIHandler
		}
		
		public function UIHandler()
		{
			_container = new Sprite();
			_screens = new Vector.<IUserInterface>();
		}
		
		public function get topScreen():IUserInterface
		{
			if (_screens.length <= 0)
				return null;
			return _screens[_screens.length - 1];
		}
		
		public function get container():Sprite
		{
			return _container;
		}
		
		public function changeUI(screen:IUserInterface):void 
		{
			removeAllScreens();
			addUI(screen);
		}
		
		public function addUI(screen:IUserInterface):void 
		{
			_screens.push(screen);
			_container.addChild(screen.graphic);
			screen.added();
		}
		
		public function removeScreen(screen:IUserInterface):void
		{
			_container.removeChild(screen.graphic);
			_screens.splice(_screens.indexOf(screen),1);
			screen.removed();
			topScreen.added();
		}
		
		public function removeAllScreens():void 	
		{
			for(var i:int = _screens.length - 1; i >= 0; i--) //reverse loop
			{
				removeScreen(_screens[i]);
			}
		}		
		
		public function update():void 
		{
			for(var i:int = 0 ; i < _screens.length; i++)
			{
				_screens[i].update();
			}
		}
	}
}