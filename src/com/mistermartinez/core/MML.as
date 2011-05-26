package com.mistermartinez.core
{
	import com.mistermartinez.utils.AdvancedSpatialManager;
	import com.mistermartinez.utils.Box2DHandler;
	import com.mistermartinez.utils.InputHandler;
	import com.mistermartinez.utils.UIHandler;
	import com.mistermartinez.utils.UpdateHandler;
	import com.mistermartinez.utils.sceneHandler.SceneHandler;
	import com.mistermartinez.utils.sceneHandler.SceneLayersLibrary;
	
	import flash.display.Stage;

	public class MML
	{
		public static function initialize(stage:Stage):void
		{
			UpdateHandler.initialize(stage);
			InputHandler.initialize(stage);
			SceneHandler.initialize(stage);
			UpdateHandler.instance.addUpdatee(SceneHandler.instance);
			UpdateHandler.instance.addUpdatee(AdvancedSpatialManager.instance);
			SceneLayersLibrary.addLayers();
			UpdateHandler.instance.addUpdatee(Box2DHandler.initialize(SceneLayersLibrary.foreground));
			UIHandler.initialize();
			UpdateHandler.instance.addUpdatee(UIHandler.instance);
			SceneLayersLibrary.ui.addChild(UIHandler.instance.container);
		}
	}
}